package com.group3.po;


public class Train {

	private Integer id;
	private String serialNum;
	private String entireRoute;
	private String bdDate;

	public Train() {
		super();
	}
	
	public Train(Integer id, String serialNum, String entireRoute, String bdDate) {
		super();
		this.id = id;
		this.serialNum = serialNum;
		this.entireRoute = entireRoute;
		this.bdDate = bdDate;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	public String getEntireRoute() {
		return entireRoute;
	}

	public void setEntireRoute(String entireRoute) {
		this.entireRoute = entireRoute;
	}

	public String getBdDate() {
		return bdDate;
	}

	public void setBdDate(String bdDate) {
		this.bdDate = bdDate;
	}

	@Override
	public String toString() {
		return "Train [id=" + id + ", serialNum=" + serialNum + ", entireRoute=" + entireRoute + ", bdDate=" + bdDate
				+ "]";
	}

}
