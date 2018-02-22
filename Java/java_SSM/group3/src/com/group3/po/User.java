package com.group3.po;

public class User {
	String id;
	String password;
	String userName;
	String mail;
	String telNum;
	String idtfType;
	String idtfNum;
	String userType;
	String address;
	String gender;
	
	public User(){
		super();
	}
	
	public User(String id, String password, String mail, String telNum) {
		super();
		this.id = id;
		this.password = password;
		this.mail = mail;
		this.telNum = telNum;
	}
	
	public User(String id, String password, String userName, String mail, String telNum, String idtfType,
			String idtfNum, String userType, String address, String gender) {
		super();
		this.id = id;
		this.password = password;
		this.userName = userName;
		this.mail = mail;
		this.telNum = telNum;
		this.idtfType = idtfType;
		this.idtfNum = idtfNum;
		this.userType = userType;
		this.address = address;
		this.gender = gender;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String user_Name) {
		this.userName = user_Name;
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

	public String getIdtfType() {
		return idtfType;
	}

	public void setIdtfType(String idtfType) {
		this.idtfType = idtfType;
	}

	public String getIdtfNum() {
		return idtfNum;
	}

	public void setIdtfNum(String idtfNum) {
		this.idtfNum = idtfNum;
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

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", password=" + password + ", userName=" + userName + ", mail=" + mail + ", telNum="
				+ telNum + ", idtfType=" + idtfType + ", idtfNum=" + idtfNum + ", userType=" + userType + ", address="
				+ address + ", gender=" + gender + "]";
	}
	
	
}
