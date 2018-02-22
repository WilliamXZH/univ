package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.AreaDAO;
import com.freshO2O.po.Area;
import com.opensymphony.xwork2.ActionSupport;

public class AreaAddAction extends ActionSupport {
	
	private int id;
	private String areaname;
	private String addr;
	private String xypoint;
	
	private String result;
	private String msg;
	private AreaDAO areaDAO;

	public String getXypoint() {
		return xypoint;
	}
	public void setXypoint(String xypoint) {
		this.xypoint = xypoint;
	}
	public String getAreaname() {
		return areaname;
	}
	public void setAreaname(String areaname) {
		this.areaname = areaname;
	}
	public void setAreaDAO(AreaDAO areaDAO) {
		this.areaDAO = areaDAO;
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
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	public String execute() throws Exception {
		
		System.out.println("areaname = "+areaname +"  addr : "+addr+"  xypoint :"+xypoint);
		
		
		long start = System.currentTimeMillis();
		List<Area> list = areaDAO.findByProperty("areaname", areaname);
		
		System.out.println();
		
		if(list.size()==0){
			Area a = new Area();
			a.setAreaname(areaname);
			a.setAddr(addr);
			a.setXypoint(xypoint);
			
			areaDAO.save(a);
			this.msg = "";
			this.result = "ok";
			
		}else{
			this.result = "fail";
			this.msg = "小区名已经存在！";
		}
		
		return SUCCESS;
	}
	
	
}
