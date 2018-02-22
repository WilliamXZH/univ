package com.freshO2O.action;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.freshO2O.dao.IndentDAO;
import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.Indent;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class OrderAddAction extends ActionSupport {
	
	private int id;
	private String orderStr;
	
	private String result;
	private String msg;
	private IndentDAO indentDAO;

	
	public String getOrderStr() {
		return orderStr;
	}
	public void setOrderStr(String orderStr) {
		this.orderStr = orderStr;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
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

		System.out.println("orderStr = " + orderStr);

		if (null != orderStr) {
			String[] strarr1 = orderStr.split(";");
			for (int i = 0; i < strarr1.length; i++) {
				Indent indent = new Indent();
				String[] arr2 = strarr1[i].split(",");
				indent.setGId(Integer.parseInt(arr2[1]));
				indent.setAccount(arr2[0]);
				indent.setGName(arr2[2]);
				indent.setGPrice(Double.parseDouble(arr2[3]));
				indent.setGNum(Integer.parseInt(arr2[4]));
				indent.setGAmount(Double.parseDouble(arr2[3])
						* Integer.parseInt(arr2[4]));
				indent.setOTime(new Date());
				indent.setOAddr(arr2[5]);
				indent.setOState("已付款");
				indentDAO.save(indent);
			}
		}
		this.msg = "";
		this.result = "ok";

		return SUCCESS;
	}
	
	
}
