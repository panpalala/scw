package com.atguigu.scw.service.authority.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.bean.TRolePermission;
import com.atguigu.scw.bean.TRolePermissionExample;
import com.atguigu.scw.bean.TRolePermissionExample.Criteria;
import com.atguigu.scw.dao.TRolePermissionMapper;
import com.atguigu.scw.service.authority.RoleAndPermissionService;

/**
 * @author panpala
 * @date 2017年8月5日
 */
@Service
public class RoleAndPermissionServiceImpl implements RoleAndPermissionService {

	
	@Autowired
	TRolePermissionMapper rolePermissionMapper;
	
	@Override
	public boolean saveRolePermissions(Integer rid,String pids) {
		//在保存角色权限时，先删除该角色权限，确保数据库角色不会重复
		TRolePermissionExample example = new TRolePermissionExample();
		Criteria criteria = example.createCriteria();
		criteria.andRoleidEqualTo(rid);
		rolePermissionMapper.deleteByExample(example);
		//用户更改权限为无，先删除他的权限，pids为空串，直接返回，不在操作数据库
		if(pids == "") {
			return true;
		}
		String[] permissions = pids.split(",");
		List<Integer> list = new ArrayList<>();
		for(String pid:permissions) {
			list.add(Integer.parseInt(pid));
		}
		int rows = rolePermissionMapper.insertBatchSelective(rid, list);
		return rows > 0;
	}

}
