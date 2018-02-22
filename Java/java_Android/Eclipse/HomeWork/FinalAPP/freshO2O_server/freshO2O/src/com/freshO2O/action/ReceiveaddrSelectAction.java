package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.ReceiveaddrDAO;
import com.freshO2O.po.Receiveaddr;
import com.opensymphony.xwork2.ActionSupport;

public class ReceiveaddrSelectAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3117296818608643220L;

	private String username ;
	
	private int pageIndex = 1;
	private int totalCount;
	private int totalPage;
	private int pageCount = 5000;
	private int gotoPage;
	private List<Receiveaddr> list;
	
	private String result;
	private String msg;
	private ReceiveaddrDAO receiveaddrDAO;

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


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<Receiveaddr> getList() {
		return list;
	}

	public void setList(List<Receiveaddr> list) {
		this.list = list;
	}

	public void setReceiveaddrDAO(ReceiveaddrDAO receiveaddrDAO) {
		this.receiveaddrDAO = receiveaddrDAO;
	}

	public String execute() throws Exception {
		
		System.out.println("username : "+username +"  pageIndex : "+pageIndex+"  totalCount : "+totalCount +" totalPage "+ totalPage);
		
		System.out.println("gotoPage : "+gotoPage);
		
		this.totalCount = receiveaddrDAO.findAll().size();
		
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
		
		list = receiveaddrDAO.findByPropertys("account", username, (this.pageIndex-1)*this.pageCount, this.pageCount);
		
		
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
