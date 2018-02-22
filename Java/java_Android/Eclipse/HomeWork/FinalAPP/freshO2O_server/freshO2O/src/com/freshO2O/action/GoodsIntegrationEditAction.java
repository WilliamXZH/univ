package com.freshO2O.action;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.opensymphony.xwork2.ActionSupport;
import java.util.List;

/**
 * Created with IntelliJ IDEA. User: Administrator Date: 14-11-19 Time: 下午6:14
 * To change this template use File | Settings | File Templates.
 */
public class GoodsIntegrationEditAction extends ActionSupport {
	
	private String g_name;
	private int g_integration;

	private String result;
	private String msg;
	
	private GoodsDAO goodsDAO;

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

	public GoodsIntegrationEditAction() {
	}

	public int getG_integration() {
		return g_integration;
	}

	public void setG_integration(int gIntegration) {
		g_integration = gIntegration;
	}

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String gName) {
		g_name = gName;
	}

	public String execute() {

		System.out.println("g_name : " + g_name + "    g_integration : "
				+ g_integration);

		List<Goods> list = goodsDAO.findByProperty("GName", g_name);

		if (list.size() != 0) {

			Goods goods = list.get(0);
			goods.setGName(g_name);
			goods.setG_integration(g_integration);

			goodsDAO.updateGoods(goods);

			this.msg = "操作成功";
			this.result = "ok";
		} else {
			this.result = "fail";
		}

		return "success";
	}

}
