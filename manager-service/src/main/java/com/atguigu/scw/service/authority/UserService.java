package com.atguigu.scw.service.authority;

import java.util.List;

import com.atguigu.scw.bean.TUser;


/**
 * @author panpala
 * @date 2017年7月28日
 */

public interface UserService {

	TUser login(TUser user);

	boolean regist(TUser user);

	List<TUser> listUsers();

	TUser getUserById(Integer id);

	boolean update(TUser user);

	void deleteUsers(Integer...id);

	List<TUser> queryUsers(String condition);

}
