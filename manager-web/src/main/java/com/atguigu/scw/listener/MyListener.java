package com.atguigu.scw.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author panpala
 * @date 2017年7月28日
 */
public class MyListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}
	
	/*
	 * 在服务器启动的时候就将项目在浏览器上的决定路径放入applicationContext的全局域对象中，方便项目中使用
	 * */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		ServletContext applicationContext = arg0.getServletContext();
		applicationContext.setAttribute("App_path", applicationContext.getContextPath());
	}

}
