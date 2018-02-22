package com.freshO2O.action;

import com.freshO2O.dao.ReceiveaddrDAO;
import com.freshO2O.po.Receiveaddr;
import com.opensymphony.xwork2.ActionSupport;

public class ReceiveaddrDelAction extends ActionSupport {
	
	private String ids;
	
	private String result;
	private String msg;
	private ReceiveaddrDAO receiveaddrDAO;

	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public void setReceiveaddrDAO(ReceiveaddrDAO receiveaddrDAO) {
		this.receiveaddrDAO = receiveaddrDAO;
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
		
		System.out.println("ids = "+ids);
		
		if(ids != null){
			String[] idarr = ids.split(",");
			
			for(int i = 0 ;i <idarr.length;i++){
				
				Receiveaddr r = receiveaddrDAO.findById(Integer.parseInt(idarr[i]));
				receiveaddrDAO.delete(r);
				
			}
		}
		
		
		
		
		this.msg = "del";
		this.result = "ok";
	
		
		return SUCCESS;
	}
	
	
}
