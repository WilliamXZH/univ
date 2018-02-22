package com.example.noname.bean;
/**
 * 新闻数据的图片
 * 
 *
 */
public class NewsDataPic {
	private String id;
    private String photo;
    private String subject;
    
	public NewsDataPic(String id, String photo, String subject) {
		super();
		this.id = id;
		this.photo = photo;
		this.subject = subject;
	}
	public NewsDataPic() {
		super();
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	@Override
	public String toString() {
		return "NewsDataPic [id=" + id + ", photo=" + photo + ", subject="
				+ subject + "]";
	}
    
    
}
