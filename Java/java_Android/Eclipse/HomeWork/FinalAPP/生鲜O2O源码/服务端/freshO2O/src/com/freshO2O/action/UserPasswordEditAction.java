package com.freshO2O.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserPasswordEditAction extends ActionSupport {
	private String name;
	private String oldpassword;
	private String password;
	private String repassword;
	private String result;
	private String msg;
	private UserDAO userDAO;

	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getOldpassword() {
		return oldpassword;
	}

	public void setOldpassword(String oldpassword) {
		this.oldpassword = oldpassword;
	}

	public String getRepassword() {
		return repassword;
	}

	public void setRepassword(String repassword) {
		this.repassword = repassword;
	}

	public String execute() throws Exception {
		
//		System.out.println("name = "+name +"  oldpassword : "+oldpassword+"  password : "+password+"  repassword : "+repassword);
//		
//		
//		long start = System.currentTimeMillis();
//		List<User> list = userDAO.findByUsername(name);
//		
//		
//		User user = list.get(0);
//		
//		if(user.getPassword().equals(oldpassword)){
//			user.setPassword(repassword);
//			userDAO.delete(user);
//			userDAO.save(user);
//			this.msg = "";
//			this.result = "ok";
//			
//		}else{
//			this.result = "fail";
//			this.msg = "当前密码错误！";
//		}
		
		return SUCCESS;
	}
	
	
}
