package com.atguigu.scw.service.authority;

import java.util.List;

import com.atguigu.scw.bean.TPermission;

/**
 * @author panpala
 * @date 2017年7月29日
 */
public interface PermissionService {

	List<TPermission> getPermissionMenu();

	List<TPermission> listAllPermissions();

	List<TPermission> getRolePermissions(Integer rid);

	List<TPermission> getPermissionMenu(Integer id);

}
