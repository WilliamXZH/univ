package com.i4evercai.bannerdemo;

public class OrderItem {
	private int iscryp;
	private int flag;
	private float cost;
	private String user;
	private String company;
	private String message;
	private String serviceType;
	
	public String getMesaage(){
		return this.message;
	}
	public void setMessage(String ms){
		this.message=ms;
	}
	public int getIsCryp(){
		return this.iscryp;
	}
	public void setIsCryp(int is){
		this.iscryp=is;
	}
	public String getServiceType() {
		return serviceType;
	}
	public void setServiceType(String serviceType) {
		this.serviceType = serviceType;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public int getFlag() {
		return flag;
	}
	public void setFlag(int flag) {
		this.flag = flag;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public OrderItem(){
		
	}
	public OrderItem(String tostr){
		this.flag=Integer.parseInt(tostr.split("_")[0]);
		this.cost=Float.parseFloat(tostr.split("_")[1]);
		this.company=tostr.split("_")[2];
		this.user=tostr.split("_")[3];
		this.serviceType=tostr.split("_")[4];
		this.message=tostr.split("_")[5];
		this.iscryp=Integer.parseInt(tostr.split("_")[6]);
	}
	public String toString(){
		return flag+"_"+cost+"_"+company+"_"+user+"_"+serviceType+"_"+message+"_"+iscryp;
	}
	
}
