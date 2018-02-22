package com.freshO2O.action;


import com.freshO2O.dao.AreaDAO;
import com.freshO2O.po.Area;
import com.opensymphony.xwork2.ActionSupport;

public class AreaDeleteAction extends ActionSupport {
	private Integer aid; 
	private String result;
	private String msg;
	private AreaDAO areaDAO;


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

	public Integer getAid() {
		return aid;
	}
	public void setAid(Integer aid) {
		this.aid = aid;
	}
	public void setAreaDAO(AreaDAO areaDAO) {
		this.areaDAO = areaDAO;
	}
	public String execute() throws Exception {
		
		System.out.println("aid = "+aid );
		
		Area a = areaDAO.findById(aid);
		
		if(a == null){
			
		}else{
			areaDAO.delete(a);
			this.result = "ok";
		}
		
		return SUCCESS;
	}
	
}
