package com.group3.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.group3.po.User;
import com.group3.service.UserService;

import net.sf.json.JSONObject;

@Controller
public class NewController {
	@Resource
	UserService userService;
	
	@RequestMapping("queryInfo/userLogin")
	public void userLogin(String name,String password,HttpSession session,HttpServletResponse response)throws IOException{
		System.out.println(name +"   "+password);
		if(name!=null&&password!=null){
			User user = userService.userLogin(new User(name,password));
			System.out.println(12345678);
			if(user!=null){
				session.setAttribute("name", user.getName());
				session.setAttribute("password", user.getPassword());
				//session.setAttribute("user", user);

				JSONObject jsonObject = JSONObject.fromObject(user);
				response.setContentType("application/json;charset=UTF-8");
				System.out.println(jsonObject);
				response.getWriter().print(jsonObject);
				System.out.println("login:"+user);
				
			}else{
				//session.setAttribute("loginStat", 2);
				System.out.println("message is dismatch with password!");
			}
			
		}else{
			//session.setAttribute("loginStat", 0);
			System.out.println("error???no message or password!");
		}
	}
	
	

}
