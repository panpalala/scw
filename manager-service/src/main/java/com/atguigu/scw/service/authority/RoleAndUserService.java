package com.atguigu.scw.service.authority;

/**
 * @author panpala
 * @date 2017年8月3日
 */
public interface RoleAndUserService {

	void saveRoles(Integer userId, String rids);

	void delRoles(Integer userId, String rids);

}
