package com.freshO2O.action;

import com.freshO2O.dao.CookBookDAO;
import com.freshO2O.po.CookBook;
import com.opensymphony.xwork2.ActionSupport;

public class CookBookDeleteAction extends ActionSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id; 
	private String result;
	private String msg;
	private CookBookDAO cookBookDAO;

	
	public void setCookBookDAO(CookBookDAO cookBookDAO) {
		this.cookBookDAO = cookBookDAO;
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
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

	
	public String execute() throws Exception {
		try{
		System.out.println("id = "+id );
		
		CookBook g = cookBookDAO.findById(id);
		
		if(g == null){
			
		}else{
			cookBookDAO.delete(g);
			this.result = "ok";
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return SUCCESS;
	}
	
}
