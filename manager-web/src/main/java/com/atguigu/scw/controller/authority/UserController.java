package com.atguigu.scw.controller.authority;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.project.MD5Util;
import com.atguigu.scw.bean.Constant;
import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TUser;
import com.atguigu.scw.service.authority.PermissionService;
import com.atguigu.scw.service.authority.RoleAndUserService;
import com.atguigu.scw.service.authority.RoleService;
import com.atguigu.scw.service.authority.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * @author panpala
 * @date 2017年7月28日
 */
@Controller
public class UserController {
	
	@Autowired
	UserService userService;
	@Autowired
	PermissionService permissionService;
	@Autowired 
	RoleService roleService;
	@Autowired 
	RoleAndUserService roleAndUserService;
	/*
	 * 接受并处理用户登录的请求
	 * */
	@RequestMapping("/login")
	public String login(TUser user,Model model,HttpSession session) {
		/*
		 * 由于用户注册时的密码经过MD5加密，所以用户登录验证时也要将密码进行MD5加密，才能从数据库查询的到
		 * */
		user.setUserpswd(MD5Util.digest(user.getUserpswd()));
		TUser tUser = userService.login(user);
		/*
		 * 判断从数据库查出的用户信息是否为空确认，用户能否登录
		 * 登录成功将封装有用户信息的对象方法session域对象中，供其他页面判断用户的登录状态
		 * 登录失败，将提示信息放入域对象中，用于页面回显，以提示用户
		 * */
		if(tUser != null) {
			session.setAttribute(Constant.LOGIN_USER, tUser);
			return "redirect:/main.html";
		}
		model.addAttribute("msg", "用户名或密码错误！");
		return "forward:/login.jsp";
	}
	
	/*
	 * 为了避免表单的重复提交，main.jsp在web-info下，不能直接重定向，所以让其他重定向的伪请求
	 * */
	@RequestMapping("/main.html")
	public String mainPage(HttpSession session,Model model) {
		//Object object = session.getAttribute(Constant.LOGIN_USER);
		TUser object = (TUser) session.getAttribute(Constant.LOGIN_USER);
		/*
		 * 从session域对象中取出TUser对象，判断是否为空确定用户的登录状态
		 * login.jsp没有在web-info中，内置视图解析器不管他，所以要去这个页面要通过转发的方式
		 * */
		if(object == null) {
			model.addAttribute("msg", "请先登录！");
			return "forward:/login.jsp";
		}
		
		/*
		 * 去main页面之前，从数据库中查询所需要的菜单，并按父子菜单分好类
		 * 菜单的数据会在多个页面共享，为了避免重复查询，菜单数据不能放在请求域中，应该放在session域中
		 * 由于用户可能在登录之后，多次通过/main.html来到主页，所以为了避免重复查询，
		 * 应该判断此时的session域对象中是否有菜单的数据集合
		 * */
		/*if(session.getAttribute(Constant.USER_MENU) == null) {
			List<TPermission> list = permissionService.getPermissionMenu();
			session.setAttribute(Constant.USER_MENU, list);
		}*/
		if(session.getAttribute(Constant.USER_MENU) == null) {
			List<TPermission> list = permissionService.getPermissionMenu(object.getId());
			session.setAttribute(Constant.USER_MENU, list);
		}
		return "main";
	}
	
	/*
	 * 接受并处理用户注册请求
	 * */
	@RequestMapping("/regist")
	public String regist(TUser user,Model model) {
		
		 boolean flag = false;
		 try {
			 flag = userService.regist(user);
			 if(flag) {
				 /*
				  * 想要让域对象带数据到页面，必须用转发，不能用重定向
				  * */
				 model.addAttribute("msg", "注册成功，请登录");
				 return "forward:/login.jsp";
			 }
		} catch (Exception e) {
			model.addAttribute("msg", "用户名已存在");
			return "forward:/reg.jsp";
		}
		 return "";
	}
	
	/*
	 * 点击用户维护，去user.jsp页面
	 * 
	 * */
	@RequestMapping("/user/maintain")
	public String toUserPage() {
		return "authority/user";
	}
	
	/*
	 * 页面加载完成之后，用ajax向服务器发请求，获取用户数据，在页面分页展示
	 * */
	@ResponseBody
	@RequestMapping("/user/json")
	public Object getAllUsers(@RequestParam(value="pageNum",defaultValue="1") Integer pageNum) {
		PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
		List<TUser> list = userService.listUsers();
		PageInfo<TUser> pageInfo = new PageInfo<>(list, Constant.NAVIGATE_PAGES);
		return pageInfo;
	}
	
	/*
	 * 处理按条件查询的请求，返回符合条件的用户信息
	 * */
	@ResponseBody
	@RequestMapping("/queryByCondition")
	public Object getUsersByCondition(@RequestParam(value="pageNum",defaultValue="1") Integer pageNum, 
									  @RequestParam("condition")String condition) {
		PageHelper.startPage(pageNum, Constant.PAGE_SIZE);
		List<TUser> list = userService.queryUsers(condition);
		PageInfo<TUser> pageInfo = new PageInfo<>(list, Constant.NAVIGATE_PAGES);
		return pageInfo;
	}
	
	
	/*
	 * 接受新增用户的请求，并保存数据到数据库
	 * */
	@ResponseBody
	@RequestMapping("/addUser")
	public Map<String, Object> saveUser(TUser user) {
		Map<String, Object> map = new HashMap<String, Object>();
		boolean flag;
		try {
			flag = userService.regist(user);
			if(flag) {
				map.put("code", 1);
				map.put("msg", "用户新增成功");
			}
		} catch (Exception e) {
			map.put("code", 0);
			map.put("msg", "用户新增失败");
		}
		return map;
	}
	
	/*
	 * 用户修改，接受请求返回当前正在修改的用户信息
	 * */
	@ResponseBody
	@RequestMapping("/getUserbyId")
	public TUser getUserById(@RequestParam("id")Integer id) {
		return userService.getUserById(id);
	}
	
	/*
	 * 用户修改，保存修改信息到数据库
	 * */
	@ResponseBody
	@RequestMapping("/updateUser")
	public Map<String, Object> updateUser(TUser user){
		Map<String, Object> map = new HashMap<>();
		try {
			userService.update(user);
			map.put("msg", "用户修改成功");
		} catch (Exception e) {
			map.put("msg", "用户修改失败");
		}
		return map;
	}
	
	/*
	 * 单个删除用户
	 * */
	@ResponseBody
	@RequestMapping("/deleteUser")
	public Map<String, Object> deleteUser(@RequestParam("id")Integer id){
		Map<String, Object> map = new HashMap<>();
		userService.deleteUsers(id);
		map.put("msg", "用户删除成功");
		return map;
	}
	
	
	/*
	 * 批量删除，将传如的参数转为数组
	 * */
	@ResponseBody
	@RequestMapping("/deleteBatchUsers")
	public Map<String, Object> deleteBatchUsers(@RequestParam("ids")String ids){
		Map<String, Object> map = new HashMap<>();
		if (ids == "") {
			map.put("msg", "用户删除成功");
			return map;
		}
		String[] strings = ids.split(",");
		Integer[] integers = new Integer[strings.length];
		for (int i = 0; i < integers.length; i++) {
			integers[i] = Integer.parseInt(strings[i]);
		}
		userService.deleteUsers(integers);
		map.put("msg", "用户删除成功");
 		return map;
	}
	
	
	/* 
	 * 回显用户角色信息
	 * */
	@ResponseBody
	@RequestMapping("/showRolesOfUser") 
	public Map<String, Object> showRolesOfUser(@RequestParam("uid")Integer userId){
		Map<String, Object> rolesMap = roleService.getUserRoles(userId);
		return rolesMap;
	}
	
	
	/*
	 * 分配角色之增加角色
	 * */
	@ResponseBody
	@RequestMapping("/addroles")
	public void addroles(@RequestParam("userid")Integer userId,
						 @RequestParam("rids")String rids){
		roleAndUserService.saveRoles(userId,rids);
	}
	
	/*
	 * 分配角色之删除角色
	 * */
	@ResponseBody
	@RequestMapping("/delroles")
	public void delroles(@RequestParam("userid")Integer userId,
						 @RequestParam("rids")String rids){
		roleAndUserService.delRoles(userId,rids);
	}
}
