package bean;

public class FeedBean {
	private int id;
	private int oid;
	private String category;
	private DataBean data;
	private String type;
	public FeedBean(int id, int oid, String category, DataBean data) {
		this.id = id;
		this.oid = oid;
		this.category = category;
		this.data = data;
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public FeedBean() {
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOid() {
		return oid;
	}
	public void setOid(int oid) {
		this.oid = oid;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public DataBean getData() {
		return data;
	}
	public void setData(DataBean data) {
		this.data = data;
	}
	@Override
	public String toString() {
		return "FeedBean [id=" + id + ", oid=" + oid + ", category=" + category
				+ ", data=" + data + "]";
	}
	
}
