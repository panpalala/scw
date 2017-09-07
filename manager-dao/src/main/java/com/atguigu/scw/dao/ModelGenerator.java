package com.atguigu.scw.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.mybatis.generator.api.MyBatisGenerator;
import org.mybatis.generator.config.Configuration;
import org.mybatis.generator.config.xml.ConfigurationParser;
import org.mybatis.generator.internal.DefaultShellCallback;

/**
 * @author panpala
 * @date 2017年7月27日
 */
public class ModelGenerator {

	public static void main(String[] args) throws Exception {
		List<String> warnings = new ArrayList<String>();
		boolean overwrite = true;
		//读取生成器配置文件
		File configFile = new File("mbg.xml");
		//配置解析器
		ConfigurationParser cp = new ConfigurationParser(warnings);
		//解析配置文件
		Configuration config = cp.parseConfiguration(configFile);
		//默认外壳回调函数
		DefaultShellCallback callback = new DefaultShellCallback(overwrite);
		//MyBatis生成器
		MyBatisGenerator myBatisGenerator = new MyBatisGenerator(config,
				callback, warnings);
		//启动生成器
		myBatisGenerator.generate(null);
	}
}
