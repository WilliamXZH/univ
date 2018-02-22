package com.freshO2O.action;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

public class LearnMaterialsSelectAction extends ActionSupport {
	
	private String name ;
	
	private String name2;
	
	private int pageIndex = 1;
	private int totalCount;
	private int totalPage;
	private int pageCount = 12;
	
	private String result;
	private String msg;
	


	public String getName2() {
		return name2;
	}


	public void setName2(String name2) {
		this.name2 = name2;
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


	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}


	public String execute() throws Exception {
		
		System.out.println("name2 : "+name2+"   name : "+name +"  pageIndex : "+pageIndex+"  totalCount : "+totalCount +" totalPage "+ totalPage);
		
		//List gclist = teacherClassDAO.findByProperty("name", name);
		
		if(this.pageIndex<=0){
			this.pageIndex = 1;
		}
		long start = System.currentTimeMillis();
//		
//		if(name == null || name.length() == 0 || "null".equals(name) ){
//			list = learnMaterialsDAO.findByPropertys((this.pageIndex-1)*this.pageCount,this.pageCount);
//			
//		}else{
//			list = learnMaterialsDAO.findByPropertys((this.pageIndex-1)*this.pageCount, this.pageCount);
//		}
		
//		if(null != list && list.size()>0){
//			this.totalCount = list.size();
//			
//			if(this.totalCount % this.pageCount == 0){
//				this.totalPage = this.totalCount / this.pageCount;
//			}else{
//				this.totalPage = this.totalCount / this.pageCount + 1;
//			}
//			
//			this.msg = "";
//			this.result = "ok";
//			
//		}else{
//			this.result = "fail";
//			this.msg = "查询到0条记录！";
//		}
		
		
		return SUCCESS;
	}
	
	
}
