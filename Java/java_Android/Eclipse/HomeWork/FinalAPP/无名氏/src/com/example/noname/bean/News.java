package com.example.noname.bean;

/**
 * 
 * 新闻类
 * 
 * ListView Item 数据对象
 * 
 *
 */
public class News {
	
	private int _id;
	private String id;
	private String oid;
	private String category;
	private NewsData data;
	
	
	
	public News() {
		super();
	}
	public News(String id, String oid, String category, NewsData data) {
		super();
		this.id = id;
		this.oid = oid;
		this.category = category;
		this.data = data;
	}
	
	
	
	public int get_id() {
		return _id;
	}
	public void set_id(int _id) {
		this._id = _id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public NewsData getData() {
		return data;
	}
	public void setData(NewsData data) {
		this.data = data;
	}
	@Override
	public String toString() {
		return "News [id=" + id + ", oid=" + oid + ", category=" + category
				+ ", data=" + data + "]";
	}
	
	
	
}
	 
