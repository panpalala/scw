package com.atguigu.scw.service.authority;

import java.util.List;
import java.util.Map;

import com.atguigu.scw.bean.TRole;

/**
 * @author panpala
 * @date 2017年8月3日
 */
public interface RoleService {

	Map<String, Object> getUserRoles(Integer userId);
	
	List<TRole> listTRoles();

	boolean saveRole(String name);

	boolean delBatchRoles(String roleIds);

	TRole getRoleById(Integer rid);

	boolean modifyRole(Integer rid, String name);
}
