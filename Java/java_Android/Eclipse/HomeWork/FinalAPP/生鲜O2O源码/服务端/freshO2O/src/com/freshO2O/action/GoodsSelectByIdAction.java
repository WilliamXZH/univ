package com.freshO2O.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class GoodsSelectByIdAction extends ActionSupport {

	private int g_id;

	private Goods g;

	private String result;
	private String msg;
	private GoodsDAO goodsDAO;

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

	public int getG_id() {
		return g_id;
	}

	public void setG_id(int gId) {
		g_id = gId;
	}


	public Goods getG() {
		return g;
	}

	public void setG(Goods g) {
		this.g = g;
	}

	public String execute() throws Exception {

		System.out.println("g_id : " + g_id);

		g = goodsDAO.findById(g_id);

		if (null != g) {

			this.msg = "";
			this.result = "ok";

		} else {
			this.result = "fail";
			this.msg = "查询到0条记录！";
		}

		return SUCCESS;
	}

}
