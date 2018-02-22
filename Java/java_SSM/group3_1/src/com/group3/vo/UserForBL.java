package com.group3.vo;
/**
 * 
 * 用户类
 * 用于业务逻辑 business logic
 *
 */
public class UserForBL {
	String username;
	String primaryPassword;
	String newPassword;
	String mail;
	String telNum;
	String userType;
	String address;
	String verifyCode;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPrimaryPassword() {
		return primaryPassword;
	}
	public void setPrimaryPassword(String primaryPassword) {
		this.primaryPassword = primaryPassword;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getVerifyCode() {
		return verifyCode;
	}
	public void setVerifyCode(String verifyCode) {
		this.verifyCode = verifyCode;
	}
	
}
