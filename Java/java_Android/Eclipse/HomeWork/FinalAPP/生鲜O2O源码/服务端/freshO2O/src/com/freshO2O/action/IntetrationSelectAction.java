package com.freshO2O.action;

import java.util.List;


import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class IntetrationSelectAction extends ActionSupport {
	
	private int id;
	private String account;
	private int integrate;
	
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
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	
	public int getIntegrate() {
		return integrate;
	}
	public void setIntegrate(int integrate) {
		this.integrate = integrate;
	}
	
	public String execute() throws Exception {
		
		System.out.println("account = "+account);
		
		
		long start = System.currentTimeMillis();
		List<User> list = userDAO.findByProperty("account", account);
		
		System.out.println();
		
		if(list.size()!=0){
			User user = list.get(0);
			integrate = user.getIntegrate();
			this.msg = "";
			this.result = "ok";
			
		}else{
			this.result = "fail";
		}
		long end = System.currentTimeMillis();
		
		return SUCCESS;
	}
	
	
}
