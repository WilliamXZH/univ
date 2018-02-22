package com.freshO2O.action;

import java.util.List;
import java.util.Map;

import com.freshO2O.dao.CookBookDAO;
import com.freshO2O.po.CookBook;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class CookBookSelectAction extends ActionSupport {
	
	private String cname ;
	
	
	private int pageIndex = 1;
	private int totalCount;
	private int totalPage;
	private int pageCount = 100;
	private int gotoPage;
	private List<CookBook> list;
	
	private String result;
	private String msg;
	private CookBookDAO cookBookDAO;
	
	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public List<CookBook> getList() {
		return list;
	}

	public void setList(List<CookBook> list) {
		this.list = list;
	}

	public void setCookBookDAO(CookBookDAO cookBookDAO) {
		this.cookBookDAO = cookBookDAO;
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



	public String execute() throws Exception {
		
		System.out.println("cname : "+cname +"  pageIndex : "+pageIndex+"  totalCount : "+totalCount +" totalPage "+ totalPage);
		
		System.out.println("gotoPage : "+gotoPage);
		
		
		if(cname != null && cname.length() != 0 && !"null".equals(cname) ){
			List l = cookBookDAO.findByProperty("cname", cname);
			if(l!=null){
				this.totalCount =l.size();
			}else{
				this.totalCount = 0;
			}
			
			
		}else {
			
			List l = cookBookDAO.findAll();
			if(null != l){
				this.totalCount = l.size();
			}else{
				this.totalCount = 0 ;
			}
			
		}
		
		
		this.totalCount = cookBookDAO.findAll().size();
		
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
		
		if(cname != null && cname.length() != 0 && !"null".equals(cname) ){
			list = cookBookDAO.findByPropertys("cname", cname, (this.pageIndex-1)*this.pageCount, this.pageCount);
			
		}else {
			list = cookBookDAO.findByPropertys((this.pageIndex-1)*this.pageCount,this.pageCount);
		}
		
		Map session = ActionContext.getContext().getSession();
			session.put("csource", "");
		
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
