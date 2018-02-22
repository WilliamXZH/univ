package com.freshO2O.action;

import com.freshO2O.dao.IndentDAO;
import com.freshO2O.po.Indent;
import com.opensymphony.xwork2.ActionSupport;

public class IndentDeleteAction extends ActionSupport {
	private Integer id; 
	private String result;
	private String msg;
	private IndentDAO indentDAO;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public void setIndentDAO(IndentDAO indentDAO) {
		this.indentDAO = indentDAO;
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
		
		System.out.println("id = "+id );
		
		Indent indent = indentDAO.findById(id);
		
		if(indent == null){
			
		}else{
			indentDAO.delete(indent);
			this.result = "ok";
		}
		
		return SUCCESS;
	}
	
}
