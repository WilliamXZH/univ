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
	
	@RequestMapping("/user/{pageName}")
	public String showUserPage(@PathVariable String pageName){
		System.out.println("user:"+pageName);
		return "user" + File.separator + pageName;
	}
	@RequestMapping("/main/{pageName}")
	public String showMainPage(@PathVariable String pageName){
		return "main" + File.separator + pageName;
	}
	@RequestMapping("/queryInfo/{pageName}")
	public String showQueryInfoPage(@PathVariable String pageName){
		System.out.println("queryInfo:"+pageName);
		return "queryInfo" + File.separator + pageName;
	}
	@RequestMapping("/userweb/{pageName}")
	public String showUserPage2(@PathVariable String pageName){
		System.out.println("userweb:"+pageName);
		return "userweb" + File.separator + pageName;
	}
	
	@RequestMapping("/orderWeb/{pageName}")
	public String showOrderwebPage(@PathVariable String pageName){
		System.out.println("orderWeb:"+pageName);
		return "orderWeb" + File.separator + pageName;
		
	}
	@RequestMapping("/purchase/{pageName}")
	public String showPurchasewebPage(@PathVariable String pageName){
		System.out.println("purchase:"+pageName);
		return "purchase" + File.separator + pageName;
	}
	@RequestMapping("/myticket/{pageName}")
	public String showBookwebPage(@PathVariable String pageName){
		System.out.println("orderWeb:"+pageName);
		return "myticket" + File.separator + pageName;
	}

}
