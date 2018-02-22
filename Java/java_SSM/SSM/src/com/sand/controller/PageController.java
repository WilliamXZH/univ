package com.sand.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



import net.sf.json.JSONObject;

/**
 * 各模块页面通配访问
 */
@Controller
public class PageController {
	
	
	
	/**
	 * 配置跳转控制器
	 * @param pageName 要访问的jsp文件名
	 * @return 视图解析器处理后的页面
	 */

	@RequestMapping("/main/{pageName}")
	public String showMainPage(@PathVariable String pageName){
		return "main" + File.separator + pageName;
	}
	@RequestMapping("/bigdata/{pageName}")
	public String showBigdataPage(@PathVariable String pageName){
		return "bigdata" + File.separator + pageName;
	}
	
	/**
	 * 接收ajax请求，返回json对象案例
	 * @param user
	 * @return json对象或普通字符串
	 */
	/*@ResponseBody
	@RequestMapping(value="testAjax",produces="text/json;charset=UTF-8")
	public String testAjax(User user) {
		user.setName("中文");
		List<User> list = new ArrayList<>();
		list.add(user);
		list.add(user);
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("user", user);
		JSONObject jsonObject = JSONObject.fromObject(map);
		System.out.println(jsonObject);
		return jsonObject.toString();
	}*/
	
	

}
