package com.group3.po;

public class Agency {
	
	Integer id;
	String name;
	String contactInf;
	String address;
	String workTime;
	String detailAddress;
	public Agency(){
		super();
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContactInf() {
		return contactInf;
	}
	public void setContactInf(String contactInf) {
		this.contactInf = contactInf;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getWorkTime() {
		return workTime;
	}
	public void setWorkTime(String workTime) {
		this.workTime = workTime;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	@Override
	public String toString() {
		return "Agency [id=" + id + ", name=" + name + ", contactInf=" + contactInf + ", address=" + address
				+ ", workTime=" + workTime + ", detailAddress=" + detailAddress + "]";
	}
	
	
}
