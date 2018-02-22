package bean;

public class MapPicBean {
	private int id;
	private String raw;
	private String photo;
	private String subject;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getRaw() {
		return raw;
	}
	public void setRaw(String raw) {
		this.raw = raw;
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
		return "MapPicBean [id=" + id + ", raw=" + raw + ", photo=" + photo
				+ ", subject=" + subject + "]";
	}
	
}
