package com.atguigu.scw.service.authority.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.project.MD5Util;
import com.atguigu.project.MyStringUtils;
import com.atguigu.scw.bean.TUser;
import com.atguigu.scw.bean.TUserExample;
import com.atguigu.scw.bean.TUserExample.Criteria;
import com.atguigu.scw.dao.TUserMapper;
import com.atguigu.scw.service.authority.UserService;

/**
 * @author panpala
 * @date 2017年7月28日
 */
@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	TUserMapper tUserMapper;
	
	/*
	 * 根据传入的Tuser对象从数据库中查询并返回
	 * */
	@Override
	public TUser login(TUser user) {
		TUserExample example = new TUserExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginacctEqualTo(user.getLoginacct());
		criteria.andUserpswdEqualTo(user.getUserpswd());
		List<TUser> list = tUserMapper.selectByExample(example);
		return list.size() == 1 ? list.get(0) : null;
	}

	@Override
	public boolean regist(TUser user) {
		user.setId(null);
		if(user.getUsername() == null) {
			user.setUsername("未命名");
		}
		user.setCreatetime(MyStringUtils.formatSimpleDate(new Date()));
		user.setUserpswd(MD5Util.digest(user.getUserpswd()));
		int rows = tUserMapper.insertSelective(user);
		return rows > 0;
	}

	
	@Override
	public List<TUser> listUsers() {
		return tUserMapper.selectByExample(null);
	}

	@Override
	public TUser getUserById(Integer id) {
		return tUserMapper.selectByPrimaryKey(id);
	}

	@Override
	public boolean update(TUser user) {
		int rows = tUserMapper.updateByPrimaryKeySelective(user);
		return rows > 0;
	}

	@Override
	public void deleteUsers(Integer... ids) {
		/*for (Integer integer : ids) {
			tUserMapper.deleteByPrimaryKey(integer);
		}*/
		tUserMapper.deleteBatchByPrimaryKey(ids);
	}

	@Override
	public List<TUser> queryUsers(String condition) {
		condition = "%" + condition + "%";
		List<TUser> list = tUserMapper.selectUsersByCondition(condition);
		return list;
	}

	
}
