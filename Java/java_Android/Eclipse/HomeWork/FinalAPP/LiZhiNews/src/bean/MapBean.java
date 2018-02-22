package bean;

import java.util.ArrayList;

public class MapBean {
	private int id;
	private String category;
	private String subject;
	private String summary;
	private String cover;
	private String format;
	private String changed;
	private String created;
	private ArrayList<MapPicBean> pics;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
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
	public String getCreated() {
		return created;
	}
	public void setCreated(String created) {
		this.created = created;
	}
	public ArrayList<MapPicBean> getPics() {
		return pics;
	}
	public void setPics(ArrayList<MapPicBean> pics) {
		this.pics = pics;
	}
	@Override
	public String toString() {
		return "MapBean [id=" + id + ", category=" + category + ", subject="
				+ subject + ", summary=" + summary + ", cover=" + cover
				+ ", format=" + format + ", changed=" + changed + ", created="
				+ created + ", pics=" + pics + "]";
	}
	
}