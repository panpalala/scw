package com.atguigu.scw.service.authority.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.dao.TUserRoleMapper;
import com.atguigu.scw.service.authority.RoleAndUserService;

/**
 * @author panpala
 * @date 2017年8月3日
 */
@Service
public class RoleAndUserServiceImpl implements RoleAndUserService {
	
	@Autowired
	TUserRoleMapper userRoleMapper;

	@Override
	public void saveRoles(Integer userId, String rids) {
		String[] roleids = rids.split(",");
		List<Integer> roleList = new ArrayList<>();
		for (String roleid : roleids) {
			roleList.add(Integer.parseInt(roleid));
		}
		userRoleMapper.insertBatchSelective(userId, roleList);
		/*for (String roleid : roleids) {
			TUserRole userRole = new TUserRole();
			userRole.setUserid(userId);
			userRole.setRoleid(Integer.parseInt(roleid));
			userRoleMapper.insertSelective(userRole);
		}*/
	}

	@Override
	public void delRoles(Integer userId, String rids) {
		String[] roleids = rids.split(",");
		List<Integer> roleList = new ArrayList<>();
		for (String roleid : roleids) {
			roleList.add(Integer.parseInt(roleid));
		}
		userRoleMapper.deleteBatchRoles(userId, roleList);
		/*for (String roleid : roleids) {
			TUserRoleExample example = new TUserRoleExample();
			Criteria criteria = example.createCriteria();
			criteria.andUseridEqualTo(userId);
			criteria.andRoleidEqualTo(Integer.parseInt(roleid));
			userRoleMapper.deleteByExample(example);
		}*/
	}

}
