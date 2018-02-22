package com.freshO2O.action;

import com.freshO2O.dao.ReceiveaddrDAO;
import com.freshO2O.po.Receiveaddr;
import com.opensymphony.xwork2.ActionSupport;

public class ReceiveaddrEditAction extends ActionSupport {
	
	private int id;
	private String username;
	private String phone;
	private String address;
	private String account;
	
	private String result;
	private String msg;
	private ReceiveaddrDAO receiveaddrDAO;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public void setReceiveaddrDAO(ReceiveaddrDAO receiveaddrDAO) {
		this.receiveaddrDAO = receiveaddrDAO;
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
		
		System.out.println("id "+id+"   account = "+account +"  phone : "+phone+"  address :"+address);
		
		
		
		Receiveaddr a = receiveaddrDAO.findById(id);
		a.setUsername(username);
		a.setPhone(phone);
		a.setAddress(address);
		a.setAccount(account);
		
		receiveaddrDAO.update(a);
		this.msg = "";
		this.result = "ok";
	
		
		return SUCCESS;
	}
	
	
}
