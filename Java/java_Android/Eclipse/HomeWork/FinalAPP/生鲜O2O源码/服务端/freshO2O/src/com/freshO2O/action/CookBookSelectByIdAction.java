package com.freshO2O.action;


import com.freshO2O.dao.CookBookDAO;
import com.freshO2O.po.CookBook;
import com.opensymphony.xwork2.ActionSupport;

public class CookBookSelectByIdAction extends ActionSupport {

	private int id;

	private CookBook c;

	private String result;
	private String msg;
	private CookBookDAO cookBookDAO;

	public void setCookBookDAO(CookBookDAO cookBookDAO) {
		this.cookBookDAO = cookBookDAO;
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

	public CookBook getC() {
		return c;
	}

	public void setC(CookBook c) {
		this.c = c;
	}

	public String execute() throws Exception {

		System.out.println("id : " + id);

		c = cookBookDAO.findById(id);

		if (null != c) {

			this.msg = "";
			this.result = "ok";

		} else {
			this.result = "fail";
			this.msg = "查询到0条记录！";
		}

		return SUCCESS;
	}

}
