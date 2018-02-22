package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class UserDeleteAction extends ActionSupport {
	private String account; 
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

	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public String execute() throws Exception {
		
		System.out.println("account = "+account );
		
		List<User> list = userDAO.findByProperty("account", account);
		
		if(list.size()==0){
			
		}else{
			userDAO.delete(list.get(0));
			this.result = "ok";
		}
		
		return SUCCESS;
	}
	
}
