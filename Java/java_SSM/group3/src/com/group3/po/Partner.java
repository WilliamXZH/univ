package com.group3.po;

public class Partner {
	
	String mainUserId;
	String name;
	String idtfType;
	String idtfNum;
	String telNum;
	String userType;
	String gender;
	public Partner(){
		super();
	}
	public String getMainUserId() {
		return mainUserId;
	}
	public void setMainUserId(String mainUserId) {
		this.mainUserId = mainUserId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public String getTelNum() {
		return telNum;
	}
	public void setTelNum(String telNum) {
		this.telNum = telNum;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public Partner(String name, String idtfType, String idtfNum, String telNum, String userType, String gender) {
		super();
		this.name = name;
		this.idtfType = idtfType;
		this.idtfNum = idtfNum;
		this.telNum = telNum;
		this.userType = userType;
		this.gender = gender;
	}
	@Override
	public String toString() {
		return "姓名：" + name + " 证件类型：" + idtfType + " 证件号："
				+ idtfNum + " 手机号：" + telNum + " 旅客类型：" + userType + " 性别：" + gender ;
	}
	

}
