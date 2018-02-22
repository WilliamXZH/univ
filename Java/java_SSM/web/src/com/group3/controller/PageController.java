package com.group3.controller;

import java.io.File;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 各模块页面通配访问
 */
@Controller
public class PageController {
	
	@RequestMapping("/queryInfo/{pageName}")
	public String showQueryInfoPage(@PathVariable String pageName){
		System.out.println("queryInfo:"+pageName);
		return "queryInfo" + File.separator + pageName;
	}
	
	
	
	
	

}
