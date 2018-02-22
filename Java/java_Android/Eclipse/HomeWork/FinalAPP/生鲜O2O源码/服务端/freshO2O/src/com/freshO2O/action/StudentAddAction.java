package com.freshO2O.action;

import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class StudentAddAction extends ActionSupport {
	private String name;
	private String password;
	private String realname;
	private String sex;
	private String gc;
	private String result;
	private String msg;
	
	


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}


	public String getGc() {
		return gc;
	}


	public void setGc(String gc) {
		this.gc = gc;
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
	
	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}


	public String execute() throws Exception {
		
	
		
		return SUCCESS;
	}
	
	
}
