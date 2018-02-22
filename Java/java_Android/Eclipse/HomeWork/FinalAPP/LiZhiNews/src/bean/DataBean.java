package bean;

import java.util.ArrayList;

public class DataBean {
	private String subject;
	private String summary;
	private String cover;
	private String pic;
	private String format;
	private String changed;
	private ArrayList<picBean> pics;
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
	public String getPic() {
		return pic;
	}
	public void setPic(String pic) {
		this.pic = pic;
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
	public ArrayList<picBean> getPics() {
		return pics;
	}
	public void setPics(ArrayList<picBean> pics) {
		this.pics = pics;
	}
	@Override
	public String toString() {
		return "DataBean [subject=" + subject + ", summary=" + summary
				+ ", cover=" + cover + ", pic=" + pic + ", format=" + format
				+ ", changed=" + changed + ", pics=" + pics + "]";
	}
	
}