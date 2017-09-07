package com.atguigu.scw.service.authority.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.dao.TPermissionMapper;
import com.atguigu.scw.service.authority.PermissionService;

/**
 * @author panpala
 * @date 2017年7月29日
 */
@Service
public class PermissionServiceImpl implements PermissionService {
	
	@Autowired
	TPermissionMapper tMapper;
	
	/*
	 * 从数据库中取出所有菜单，并按照父子关系封装到集合中，并返回
	 * 考虑到时间复杂度，不使用嵌套循环，而分为两次循环，以空间换时间
	 * */
	@Override
	public List<TPermission> getPermissionMenu() {
		//获取所有的父子菜单
		List<TPermission> list = tMapper.selectByExample(null);
		return buildMenu(list);
	}
	
	
	//构建用户菜单
	public List<TPermission> buildMenu(List<TPermission> list){
		//用于封装所有整理好父子关系的菜单数据集合
		List<TPermission> menu = new ArrayList<>();
		//用于临时存储父菜单
		Map<Integer, TPermission> map = new HashMap<Integer, TPermission>();
		//遍历所有菜单，将父菜单放入menu和map中
		for (TPermission tPermission : list) {
			if (tPermission.getPid() == 0) {
				//用于给父菜单的子菜单集合初始化
				List<TPermission> childs = tPermission.getChilds();
				if(childs == null) {
					childs = new ArrayList<>();
					tPermission.setChilds(childs);
				}
				//此处map和menu中放入的是同一个父菜单对象
				menu.add(tPermission);
				map.put(tPermission.getId(), tPermission);
			}
		}
		//经过上面的循环遍历，父菜单已经被装配到集合中，子菜单集合也创建出来了
		
		//往各个父菜单的子菜单集合中填充子菜单
		for (TPermission tPermission : list) {
			//筛选出所有的子菜单
			if(tPermission.getPid() != 0) {
				//子菜单的pid等于父菜单的id值，利用子菜单的pid从map集合中取出当前子菜单所对应的父菜单
				TPermission permission = map.get(tPermission.getPid());
				//将子菜单加入到它所对应的父菜单中
				permission.getChilds().add(tPermission);
			}
		}
		return menu;
	}
	
	@Override
	public List<TPermission> listAllPermissions() {
		return tMapper.selectByExample(null);
	}

	@Override
	public List<TPermission> getRolePermissions(Integer rid) {
		List<TPermission> list = tMapper.getRolePermissions(rid);
		return list;
	}

	
	@Override
	public List<TPermission> getPermissionMenu(Integer id) {
		List<TPermission> menu = tMapper.selectUserPermissions(id);
		return buildMenu(menu);
	}

}
