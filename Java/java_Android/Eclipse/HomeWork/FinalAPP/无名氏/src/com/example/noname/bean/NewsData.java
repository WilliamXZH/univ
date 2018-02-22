package com.example.noname.bean;

import java.util.ArrayList;

/**
 * 新闻数据类
 * 
 *
 */

public class NewsData {
	
	private String  subject;
	private String  summary;
	private String cover;
	private String format;
	private String changed;
    private ArrayList<NewsDataPic> pics;
    
    
    
	public NewsData() {
		super();
	}
	public NewsData(String subject, String summary, String cover,
			String format, String changed, ArrayList<NewsDataPic> pics) {
		super();
		this.subject = subject;
		this.summary = summary;
		this.cover = cover;
		this.format = format;
		this.changed = changed;
		this.pics = pics;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getChanged() {
		return changed;
	}
	public void setChanged(String changed) {
		this.changed = changed;
	}
	public ArrayList<NewsDataPic> getPics() {
		return pics;
	}
	public void setPics(ArrayList<NewsDataPic> pics) {
		this.pics = pics;
	}
	@Override
	public String toString() {
		return "NewsData [subject=" + subject + ", summary=" + summary
				+ ", cover=" + cover + ", format=" + format + ", changed="
				+ changed + ", pics=" + pics + "]";
	}
    
    
    
    
}
