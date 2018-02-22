package com.freshO2O.action;

import java.util.List;
import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.opensymphony.xwork2.ActionSupport;

public class GoodsSelectByCategoryAction extends ActionSupport {

	private int category_id;

	List<Goods> list;

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

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int categoryId) {
		category_id = categoryId;
	}

	public List<Goods> getList() {
		return list;
	}

	public void setList(List<Goods> list) {
		this.list = list;
	}

	public String execute() throws Exception {

		System.out.println("category_id : " + category_id);

		if(category_id == 6){
			list = goodsDAO.findAll();
		}else{
			list = goodsDAO.findByProperty("categoryId", category_id);
		}
		

		if (null != list) {

			this.msg = "";
			this.result = "ok";

		} else {
			this.result = "fail";
			this.msg = "查询到0条记录！";
		}

		return SUCCESS;
	}

}
