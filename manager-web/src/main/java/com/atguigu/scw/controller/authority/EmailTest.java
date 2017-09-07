package com.atguigu.scw.controller.authority;

import org.apache.commons.mail.SimpleEmail;
import org.junit.Test;

/**
 * @author panpala
 * @date 2017年8月4日
 */
public class EmailTest {
	
	@Test
	public void test1() throws Exception {
		SimpleEmail email = new SimpleEmail();
		email.setHostName("127.0.0.1");
		email.setAuthentication("sdau_lmz@atguigu.com", "123456");
		email.setFrom("sdau_lmz@atguigu.com");
		email.addTo("779196197@atguigu.com");
		email.setSubject("炤哥真帅");
		email.setMsg("人品爆炸");
		email.send();
		
	}
}
