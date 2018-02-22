package book_user;


public class BookMenu {
	private int BookId;
	private String Name;
	private int Total;
	private int Left;
	private int Lend;
	private String Type;
	private String AuthorName;
	private int picture;
	public BookMenu(int id,String name,int total,int left,int lend,String type,String authorName){
		this.BookId=id;
		this.Name=name;
		this.Total=total;
		this.Left=left;
		this.Lend=lend;
		this.Type=type;
		this.setAuthorName(authorName);
	}
	public void test() {
		System.out.println(AuthorName);
	}
	public int getLeft() {
		return Left;
	}
	public void setLeft(int left) {
		Left = left;
	}
	public int getTotal() {
		return Total;
	}
	public void setTotal(int total) {
		Total = total;
	}
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public int getId() {
		return BookId;
	}
	public void setId(int id) {
		BookId = id;
	}
	public int getLend() {
		return Lend;
	}
	public void setLend(int lend) {
		Lend = lend;
	}
	public String getType() {
		return Type;
	}
	public void setType(String type) {
		Type = type;
	}
	public String getAuthorName() {
		return AuthorName;
	}
	public void setAuthorName(String authorName) {
		AuthorName = authorName;
	}
	public int getPicture() {
		return picture;
	}
	public void setPicture(int picture) {
		this.picture = picture;
	}
	
}
