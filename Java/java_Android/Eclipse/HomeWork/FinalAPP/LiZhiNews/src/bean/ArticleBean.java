package bean;

import java.util.ArrayList;

public class ArticleBean {
	private int id;
	private String category;
	private String subject;
	private String subtitle;
	private String summary;
	private ArrayList<ContentBean> contents;
	private String format;
	private String cover;
	private String pic;
	private String origin;
	private String origined;
	private String attachs;
	private String changed;
	private String created;
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
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public ArrayList<ContentBean> getContents() {
		return contents;
	}
	public void setContents(ArrayList<ContentBean> contents) {
		this.contents = contents;
	}
	public String getFormat() {
		return format;
	}
	public void setFormat(String format) {
		this.format = format;
	}
	public String getCover() {
		return cover;
	}
	public void setCover(String cover) {
		this.cover = cover;
	}
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
	}
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	public String getOrigined() {
		return origined;
	}
	public void setOrigined(String origined) {
		this.origined = origined;
	}
	public String getAttachs() {
		return attachs;
	}
	public void setAttachs(String attachs) {
		this.attachs = attachs;
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
	@Override
	public String toString() {
		return "ArticleBean [id=" + id + ", category=" + category
				+ ", subject=" + subject + ", subtitle=" + subtitle
				+ ", summary=" + summary + ", contents=" + contents
				+ ", format=" + format + ", cover=" + cover + ", pic=" + pic
				+ ", origin=" + origin + ", origined=" + origined
				+ ", attachs=" + attachs + ", changed=" + changed
				+ ", created=" + created + "]";
	}
	
}
