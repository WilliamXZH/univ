package com.freshO2O.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class UserEditAction extends ActionSupport {
	private int id;
	private String account;
	private String nickname;
	private String password;
	private String email;
	private String phone;
	private String addr;
	private Date birthday;
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
	
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
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
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public Date getBirthday() {
		return birthday;
	}
	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}
	public int getIntegrate() {
		return integrate;
	}
	public void setIntegrate(int integrate) {
		this.integrate = integrate;
	}
	public String execute() throws Exception {
		
		System.out.println("account = "+account +"  birthday : "+birthday+"  integrate : "+integrate);
		List<User> list = userDAO.findByProperty("account", account);
		
		System.out.println();
		
		if(list.size()>0){
			User user = list.get(0);
			user.setAccount(account);
			user.setNickname(nickname);
			user.setEmail(email);
			user.setPassword(password);
			user.setPhone(phone);
			user.setAddr(addr);
			user.setIntegrate(0);
			
			if(birthday != null){
				user.setBirthday(birthday);
			}else{
				user.setBirthday(null);
			}
			
			
//			Date date = new Date();
//			DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");  
//	        System.out.println(format1.format(date));
	        
//			user.setRegistertime(date);
			userDAO.update(user);
			this.msg = "";
			this.result = "ok";
			
		}else{
			this.result = "fail";
		}
		return SUCCESS;
	}
	
	
}
