package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class LoginAction extends ActionSupport {
	private String account;
	private String password;
	private String addr;
	private String result;
	private String msg;
	private UserDAO userDAO;

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}


	public String execute() throws Exception {

		System.out.println("account : "+account);

		List list = userDAO.findByProperty("account", account);

		if (list.size() == 0) {
			result = "error";
			msg = "账户名不存在";
		} else {
			User user = (User) list.get(0);
			if (password.equals(user.getPassword())) {
				addr=user.getRecvaddr();
				result = "ok";
			} else {
				result = "error";
				msg = "密码不正确";
			}
		}
		
		return SUCCESS;
	}

}
