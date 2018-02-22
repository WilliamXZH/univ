package com.freshO2O.action;

import java.util.List;

import com.freshO2O.dao.UserDAO;
import com.freshO2O.po.User;
import com.opensymphony.xwork2.ActionSupport;

public class UserSelectAction extends ActionSupport {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3117296818608643220L;

	private String username ;
	
	private int pageIndex = 1;
	private int totalCount;
	private int totalPage;
	private int pageCount = 12;
	private int gotoPage;
	private List<User> list;
	
	private String result;
	private String msg;
	private UserDAO userDAO;

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
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


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public List<User> getList() {
		return list;
	}

	public void setList(List<User> list) {
		this.list = list;
	}

	public String execute() throws Exception {
		
		System.out.println("username : "+username +"  pageIndex : "+pageIndex+"  totalCount : "+totalCount +" totalPage "+ totalPage);
		
		System.out.println("gotoPage : "+gotoPage);
		
		this.totalCount = userDAO.findAll().size();
		
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
		
		if(username == null || username.length() == 0 || "null".equals(username) ){
			list = userDAO.findByPropertys((this.pageIndex-1)*this.pageCount,this.pageCount);
			
		}else{
			list = userDAO.findByPropertys("account", username, (this.pageIndex-1)*this.pageCount, this.pageCount);
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
