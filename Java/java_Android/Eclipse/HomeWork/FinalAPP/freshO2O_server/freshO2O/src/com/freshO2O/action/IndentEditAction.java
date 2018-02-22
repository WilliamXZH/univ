package com.freshO2O.action;

import com.freshO2O.dao.IndentDAO;
import com.freshO2O.po.Indent;
import com.opensymphony.xwork2.ActionSupport;

public class IndentEditAction extends ActionSupport {
	private int id;
	private int state;
	private String result;
	private String msg;
	private IndentDAO indentDAO;
	
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
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
		
		System.out.println("state = "+state +"  id : "+id);
		Indent  indent = indentDAO.findById(id);

		if(indent!=null){
		
			if(state == 2){
				indent.setOState("已发货");
			}else if(state == 3){
				indent.setOState("订单已完成");
			}
			
			indentDAO.update(indent);
			
			this.msg = "操作成功";
			this.result = "ok";
		}else{
			this.result = "fail";
		}

		return SUCCESS;
	}
	
	
}
