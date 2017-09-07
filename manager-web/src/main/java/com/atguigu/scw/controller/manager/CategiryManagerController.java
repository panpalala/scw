package com.atguigu.scw.controller.manager;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.scw.bean.Constant;
import com.atguigu.scw.bean.TAccountTypeCert;
import com.atguigu.scw.bean.TCert;
import com.atguigu.scw.service.manager.CertService;

/**
 * @author panpala
 * @date 2017年8月5日
 */
@Controller
public class CategiryManagerController {
	
	@Autowired
	CertService certService;
	
	/*
	 * 跳转到分类管理页面,并带数据过去，用于回显
	 * */
	@RequestMapping("/category/manager")
	public String toCategoryManager(Model model) {
		//将组织类型加入到集合中返回
		List<Integer> types = new ArrayList<>();
		types.add(Constant.BUSINESS_COMPANY);
		types.add(Constant.INDIVIDUAL_BUSINESS);
		types.add(Constant.SINGLE_BUSINESS);
		types.add(Constant.GOVERNMENT_ORGANIZATION);
		model.addAttribute("types", types);
		List<TCert> certs = certService.listAllCerts();
		//获取所有资质返回
		model.addAttribute("certs", certs);
		return "manager/type";
	}
	
	/*
	 * 返回每个账户类型的所有资质
	 * 
	 * */
	@ResponseBody
	@RequestMapping("/typecert/json")
	public List<TAccountTypeCert> listAccountTypeCerts(){
		List<TAccountTypeCert> list = certService.listAllTypeCerts();
		return list;
	}
	
	/*
	 * 保存用户资质
	 * */
	@ResponseBody
	@RequestMapping("/save/accountCerts")
	public Map<String, Object> saveAccountCerts(TAccountTypeCert accountTypeCert){
		Map<String, Object> map = new HashMap<String, Object>();
		certService.insertAccountTypeCert(accountTypeCert);
		map.put("msg", "资质保存成功");
		return map;
	}
	
	
	/*
	 * 保存用户资质
	 * */
	@ResponseBody
	@RequestMapping("/delete/accountCerts")
	public Map<String, Object> deleteAccountCerts(TAccountTypeCert accountTypeCert){
		Map<String, Object> map = new HashMap<String, Object>();
		certService.deletetAccountTypeCert(accountTypeCert);
		map.put("msg", "资质删除成功");
		return map;
	}
}
