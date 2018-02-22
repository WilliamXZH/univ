package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.Goods;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class GoodsDeleteAction extends ActionSupport {
	private int g_id; 
	private String result;
	private String msg;
	private GoodsDAO goodsDAO;

	
	public int getG_id() {
		return g_id;
	}
	public void setG_id(int gId) {
		g_id = gId;
	}
	public void setGoodsDAO(GoodsDAO goodsDAO) {
		this.goodsDAO = goodsDAO;
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
		
		System.out.println("g_id = "+g_id );
		
		Goods g = goodsDAO.findById(g_id);
		
		if(g == null){
			
		}else{
			goodsDAO.delete(g);
			this.result = "ok";
		}
		
		return SUCCESS;
	}
	
}
