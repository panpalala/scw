package com.atguigu.scw.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atguigu.scw.bean.TUser;
import com.atguigu.scw.dao.TUserMapper;

/**
 * @author panpala
 * @date 2017年7月27日
 */

@Service
public class ScwService {
	
	@Autowired
	TUserMapper tUserMapper;
	
	public List<TUser> listAllTUsers() {
		return tUserMapper.selectByExample(null);
	}
	
	public TUser geTUser(Integer id) {
		return tUserMapper.selectByPrimaryKey(id);
	}
	
	public int deleteTUser(Integer id) {
		return tUserMapper.deleteByPrimaryKey(id);
	}
	
}
