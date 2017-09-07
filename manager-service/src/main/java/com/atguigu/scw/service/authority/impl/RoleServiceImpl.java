package com.atguigu.scw.service.authority.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.dao.TRoleMapper;
import com.atguigu.scw.service.authority.RoleService;

/**
 * @author panpala
 * @date 2017年8月3日
 */
@Service
public class RoleServiceImpl implements RoleService {
	
	@Autowired
	TRoleMapper roleMapper;
	
	@Override
	public Map<String, Object> getUserRoles(Integer userId) {
		Map<String, Object> roleMap = new HashMap<String, Object>();
		List<TRole> allRoles = roleMapper.selectByExample(null);
		List<TRole> userRoles = roleMapper.getUserTRoles(userId);
		//将所有角色和为分配的角色存入集合返回
		roleMap.put("allRoles", allRoles);
		roleMap.put("userRoles", userRoles);
		return roleMap;
	}

	@Override
	public List<TRole> listTRoles() {
		return roleMapper.selectByExample(null);
	}

	@Override
	public boolean saveRole(String name) {
		List<TRole> roles = roleMapper.selectByExample(null);
		//避免插入重复的角色名
		for (TRole role : roles) {
			if(role.getName() == name) {
				return false;
			}
		}
		TRole role = new TRole();
		role.setName(name);
		int row = roleMapper.insertSelective(role);
		return row > 0;
	}

	@Override
	public boolean delBatchRoles(String roleIds) {
		String[] ids = roleIds.split(",");
		int delCount = 0;
		for (String id : ids) {
			roleMapper.deleteByPrimaryKey(Integer.parseInt(id));
			delCount++;
		}
		return delCount > 0;
	}

	@Override
	public TRole getRoleById(Integer rid) {
		return roleMapper.selectByPrimaryKey(rid);
	}
	
	@Override
	public boolean modifyRole(Integer rid, String name) {
		TRole role = new TRole();
		role.setId(rid);
		role.setName(name);
		int row = roleMapper.updateByPrimaryKey(role);
		return row > 0;
	}

}
