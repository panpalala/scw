package com.atguigu.scw.controller.manager;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.activiti.engine.RepositoryService;
import org.activiti.engine.impl.util.IoUtil;
import org.activiti.engine.repository.ProcessDefinition;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.atguigu.scw.bean.Constant;
import com.atguigu.scw.bean.ScwReturnInfo;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageInfo;

/**
 * @author panpala
 * @date 2017年8月10日
 */
@Controller
public class ActivitiController {
	
	//流程框架的仓库服务，将文件保存在本地
	@Autowired
	RepositoryService repositoryService;

	@RequestMapping("/activiti/manager")
	public String toProcessPage() {
		return "manager/process";
	}
	
	/*
	 * 处理文件上传的请求
	 * */
	@ResponseBody
	@RequestMapping("/uploadActivitiFile")
	public ScwReturnInfo<Object> uploadFile(@RequestParam("activitiFile")MultipartFile file){
		//获取文件名
		String filename = file.getOriginalFilename();
		try {
			//获取文件输入流
			InputStream inputStream = file.getInputStream();
			//流程部署：创建部署-引入输入流-部署
			repositoryService.createDeployment()
							 .addInputStream(filename, inputStream)
							 .category("实名审核")
							 .deploy();
			return ScwReturnInfo.success(null, "流程部署成功", null);
		} catch (IOException e) {
			e.printStackTrace();
			return ScwReturnInfo.success(null, "流程部署失败", null);
		}
	}
	
	
	/*
	 * 返回所有流程定义信息
	 * */
	@ResponseBody
	@RequestMapping("/activiti/pds")
	public ScwReturnInfo<Object> listActivitiPds(@RequestParam(value="pageNum",defaultValue="1")
													Integer pageNum){
		//创建map,存放用户自定义信息
		Map<String, Object> map = new HashMap<String, Object>();
		//创建Page对象，传入当前页码和每页显示的记录数
		Page<Object> page = new Page<>(pageNum, Constant.PAGE_SIZE);
		//按照流程定义查询，流程总数
		long count = repositoryService.createProcessDefinitionQuery().count();
		//设置总记录数
		page.setTotal(count);
		//利用pageInfo进行分页条构建
		PageInfo<Object> pageInfo = new PageInfo<>(page, 3);
		//查询每页需要显示的信息,listPage(查询时记录的开始编号，查询每次返回的记录数)
		List<ProcessDefinition> list = repositoryService.createProcessDefinitionQuery().listPage(page.getStartRow(), Constant.PAGE_SIZE);
		//为了解决json自引用问题，将页面要用的数据放在map中，再存入List中，最后将list存入返回信息类的map中
		List<Map<String, Object>> pdList = new ArrayList<>();
		for (ProcessDefinition pd : list) {
			Map<String, Object> pdMap = new HashMap<>();
			pdMap.put("id", pd.getId());
			pdMap.put("category", pd.getCategory());
			pdMap.put("name", pd.getName());
			pdMap.put("version", pd.getVersion());
			pdMap.put("key", pd.getKey());
			pdList.add(pdMap);
		}
		map.put("pageInfo", pageInfo);
		map.put("pdList", pdList);
		
		return ScwReturnInfo.success(null, page.getStartRow() + "/" + (pageNum-1)*Constant.PAGE_SIZE, map);
	}
	
	
	/*
	 * 返回流程图的二进制数组
	 * */
	@ResponseBody
	@RequestMapping("/showProcessImg")
	public byte[] getProcessImg(@RequestParam("pid")String pid) {
		InputStream inputStream = repositoryService.getProcessDiagram(pid);
		byte[] byteArray;
		try {
			//将输入流转化为二进制数组
			byteArray = IOUtils.toByteArray(inputStream);
			inputStream.close();
			return byteArray;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/*
	 *删除流程 
	 * 
	@RequestMapping("/deleteProcess")
	public void deleteProcess(@RequestParam("pid")String pid) {
		repositoryService.deleteDeployment(pid);
	}*/
}
