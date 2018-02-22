package com.example.noname.utils;

public class TopPager {

	private String id;
	private String oid;
	private String category;
	private String photo;
	private String subject;

	public TopPager() {
		super();
	}

	public TopPager(String id, String oid, String category, String photo,
			String subject) {
		super();
		this.id = id;
		this.oid = oid;
		this.category = category;
		this.photo = photo;
		this.subject = subject;
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
		return "TopPager [id=" + id + ", oid=" + oid + ", category=" + category
				+ ", photo=" + photo + ", subject=" + subject + "]";
	}

}
