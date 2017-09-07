package com.atguigu.scw.controller.authority;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.bean.Constant;
import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.bean.TRolePermission;
import com.atguigu.scw.service.authority.PermissionService;
import com.atguigu.scw.service.authority.RoleAndPermissionService;
import com.atguigu.scw.service.authority.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;


/**
 * @author panpala
 * @date 2017年8月4日
 */
@Controller
public class RoleController {

	@Autowired
	RoleService roleService;
	
	@Autowired
	PermissionService permissionService;
	
	@Autowired
	RoleAndPermissionService roleAndPermissionService;
	/*
	 * 接受请求，跳转到角色维护页面 
	 * */
	@RequestMapping("/role/maintain")
	public String toRoleMaintain(Model model) {
		return "authority/role";
	}
	
	/*
	 * 处理页面加载完成发送过来的异步请求，返回所有角色数据
	 * */
	@ResponseBody
	@RequestMapping("/role/json")
	public PageInfo<TRole> listRoles(@RequestParam(value = "pageNum", 
									defaultValue = "1") Integer pageNum){
		PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
		List<TRole> roles = roleService.listTRoles();
		PageInfo<TRole> pageInfo = new PageInfo<>(roles, Constant.NAVIGATE_PAGES);
		return pageInfo;
	}
	
	/*
	 * 为保存按钮提交的角色信息
	 * */
	@ResponseBody
	@RequestMapping("/addRole")
	public Map<String, Object> addRole(@RequestParam("name")String name){
		System.out.println(name);
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag = roleService.saveRole(name);
		if(flag) {
			map.put("msg", "保存成功");
		}else {
			map.put("msg", "保存失败");
		}
		return map;
	}
	
	
	/*
	 * 批量删除
	 * */
	@ResponseBody
	@RequestMapping("/delBatchRoles")
	public Map<String, Object> delBatchRoles(@RequestParam("roleIds")String roleIds){
		Map<String, Object> map = new HashMap<>();
		boolean flag = roleService.delBatchRoles(roleIds);
		if(flag) {
			map.put("msg", "删除成功");
		}else {
			map.put("msg", "删除失败");
		}
		return map;
	}
	
	/*
	 * 获取单个角色信息，用于回显
	 * */
	@ResponseBody
	@RequestMapping("/getRoleById")
	public TRole getRoleById(@RequestParam("rid")Integer rid) {
		return roleService.getRoleById(rid);
	}
	
	/*
	 * 修改角色信息
	 * */
	@ResponseBody
	@RequestMapping("/modifyRole")
	public Map<String, Object> modifyRole(@RequestParam("rid")Integer rid,
											@RequestParam("name")String name) {
		Map<String, Object> map = new HashMap<>();
		boolean flag = roleService.modifyRole(rid,name);
		if(flag) {
			map.put("msg", "修改成功");
		}else {
			map.put("msg", "修改失败");
		}
		return map;
	}
	
	/*
	 * 以json的方式返回所有的权限信息
	 * */
	@ResponseBody
	@RequestMapping("/rolejsons")
	public List<TPermission> listPermissions(){
		return permissionService.listAllPermissions();
	}
	
	
	/*
	 * 通过传入的角色rid来查询此角色所对应的权限
	 * */
	@ResponseBody
	@RequestMapping("/currentRolePermissions")
	public List<TPermission> getRolePermissions(@RequestParam("rid")Integer rid) {
		List<TPermission> list = permissionService.getRolePermissions(rid);
		return list;
	}
	
	/*
	 * 保存角色对应的权限，相当于给rolePermission中插入数据
	 * */
	@ResponseBody
	@RequestMapping("/saveRolePermissions")
	public Map<String, Object> saveRolePermissions(@RequestParam("rid")Integer rid,@RequestParam("pids")String pids){
		Map<String, Object> map = new HashMap<>();
		try {
			boolean flag = roleAndPermissionService.saveRolePermissions(rid,pids);
			if(flag) {
				map.put("msg", "权限分配成功");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("msg", "权限分配失败");
		}
		return map;
	}
}
