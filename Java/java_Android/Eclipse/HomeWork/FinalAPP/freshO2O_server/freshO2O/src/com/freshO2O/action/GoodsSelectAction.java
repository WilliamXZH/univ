package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.GoodsDAO;
import com.freshO2O.po.Goods;
import com.opensymphony.xwork2.ActionSupport;

public class GoodsSelectAction extends ActionSupport {
	
	private String g_name ;
	
	private String g_reco;
	
	private int pageIndex = 1;
	private int totalCount;
	private int totalPage;
	private int pageCount = 12;
	private int gotoPage;
	private List<Goods> list;
	
	private String result;
	private String msg;
	private GoodsDAO goodsDAO;
	

	public String getG_reco() {
		return g_reco;
	}

	public void setG_reco(String gReco) {
		g_reco = gReco;
	}

	public void setGoodsDAO(GoodsDAO goodsDAO) {
		this.goodsDAO = goodsDAO;
	}

	public int getGotoPage() {
		return gotoPage;
	}

	public void setGotoPage(int gotoPage) {
		this.gotoPage = gotoPage;
	}

	public int getPageCount() {
		return pageCount;
	}

	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
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

	public String getG_name() {
		return g_name;
	}

	public void setG_name(String gName) {
		g_name = gName;
	}

	public List<Goods> getList() {
		return list;
	}

	public String execute() throws Exception {
		
		System.out.println("g_name : "+g_name +"  pageIndex : "+pageIndex+"  totalCount : "+totalCount +" totalPage "+ totalPage);
		
		System.out.println("gotoPage : "+gotoPage);
		
		System.out.println("g_reco : "+g_reco);
		
		if(g_name != null && g_name.length() != 0 && !"null".equals(g_name) ){
			List l = goodsDAO.findByProperty("GName", g_name);
			if(l!=null){
				this.totalCount =l.size();
			}else{
				this.totalCount = 0;
			}
			
			
		}else if(g_reco != null && g_reco.length() != 0 && !"null".equals(g_reco) && !g_reco.equals("3")) {

			List l = goodsDAO.findByProperty("g_reco", g_reco);
			if(l!=null){
				this.totalCount =l.size();
			}else{
				this.totalCount = 0;
			}
		}else {
			
			List l = goodsDAO.findAll();
			if(null != l){
				this.totalCount = l.size();
			}else{
				this.totalCount = 0 ;
			}
			
		}
		
		
		this.totalCount = goodsDAO.findAll().size();
		
		if(this.totalCount % this.pageCount == 0){
			this.totalPage = this.totalCount / this.pageCount;
		}else{
			this.totalPage = this.totalCount / this.pageCount + 1;
		}
		
		if(this.gotoPage == 2){
			this.pageIndex = totalPage;
		}
		if(this.gotoPage == -2){
			this.pageIndex = 1;
		}
		if(this.gotoPage == -1){
			this.pageIndex --;
			if(this.pageIndex<=0){
				this.pageIndex = 1;
			}
		}
		if(this.gotoPage == 1){
			this.pageIndex ++;
			if(this.pageIndex>this.totalPage){
				this.pageIndex = this.totalPage;
			}
		}
		
		System.out.println("pageIndex : "+pageIndex);
		
		long start = System.currentTimeMillis();
		
		if(g_name != null && g_name.length() != 0 && !"null".equals(g_name) ){
			list = goodsDAO.findByPropertys("GName", g_name, (this.pageIndex-1)*this.pageCount, this.pageCount);
			
		}else if(g_reco != null && g_reco.length() != 0 && !"null".equals(g_reco) && !g_reco.equals("3")) {
			list = goodsDAO.findByPropertys("g_reco", g_reco, (this.pageIndex-1)*this.pageCount, this.pageCount);
			
		}else {
			list = goodsDAO.findByPropertys((this.pageIndex-1)*this.pageCount,this.pageCount);
		}
		
		if(null != list && list.size()>0){
			
			this.msg = "";
			this.result = "ok";
			
		}else{
			this.result = "fail";
			this.msg = "查询到0条记录！";
		}
		
		return SUCCESS;
	}
	
	
}
