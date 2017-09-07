package com.atguigu.scw.bean;

import java.util.Map;


/**
 * @author panpala
 * @date 2017年8月10日
 * 规范控制器给页面返回信息的类
 */
public class ScwReturnInfo<T> {

	// 方法执行状态码
	private Integer code;
	// 方法执行后的提示信息
	private String msg;
	// 返回页面需要带的数据
	private T content;
	// 用户自定义信息
	private Map<String, Object> map;
	
	//方法执行成功调用
	public static <T> ScwReturnInfo<T> success(T content,String msg,Map<String, Object> map){
		ScwReturnInfo<T> returnInfo = new ScwReturnInfo<>();
		returnInfo.setCode(1);
		returnInfo.setMsg(msg);
		returnInfo.setContent(content);
		returnInfo.setMap(map);
		return returnInfo;
	}
	
	//方法执行失败后调用
	public static <T> ScwReturnInfo<T> fail(T content,String msg,Map<String, Object> map){
		ScwReturnInfo<T> returnInfo = new ScwReturnInfo<>();
		returnInfo.setCode(0);
		returnInfo.setMsg(msg);
		returnInfo.setContent(content);
		returnInfo.setMap(map);
		return returnInfo;
	}
	

	public Integer getCode() {
		return code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public T getContent() {
		return content;
	}

	public void setContent(T content) {
		this.content = content;
	}

	public Map<String, Object> getMap() {
		return map;
	}

	public void setMap(Map<String, Object> map) {
		this.map = map;
	}

}
