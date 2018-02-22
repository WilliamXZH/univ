package com.freshO2O.action;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA. User: Administrator Date: 14-11-19 Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class CookBookAddMaterielAction extends ActionSupport {
	
	private Integer g_id;

	private String result;
	private String msg;
	
	private GoodsDAO goodsDAO;
	
	private Goods g;

	public void setGoodsDAO(GoodsDAO goodsDAO) {
		this.goodsDAO = goodsDAO;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public CookBookAddMaterielAction() {
	}

	
	public Integer getG_id() {
		return g_id;
	}

	public void setG_id(Integer gId) {
		g_id = gId;
	}

	public Goods getG() {
		return g;
	}

	public void setG(Goods g) {
		this.g = g;
	}

	public String execute() {
		
		System.out.println("g_id : " + g_id);

		g = goodsDAO.findById(g_id);
		
		if (null != g) {
			
			Map session = ActionContext.getContext().getSession();
			String csource = (String)session.get("csource");
			if(null!=csource){
				session.put("csource", csource+" "+g.getGName());
			}else{
				session.put("csource", g.getGName());
			}
			

			this.msg = "";
			this.result = "ok";

		} else {
			this.result = "fail";
			this.msg = "查询到0条记录！";
		}

		return "success";
	}

}
