package pers.william.news;

public class Comment {
	private int cmmt_id;
	private int owner_id;
	private int about_id;
	private String content;
	
	public Comment(int id,int user,int news,String cntt){
		this.cmmt_id=id;
		this.content=cntt;
		this.owner_id=user;
		this.about_id=news;
	}
	
	public int getId(){
		return this.cmmt_id;
	}
	public int getOwner(){
		return this.owner_id;
	}
	public int getAbout(){
		return this.about_id;
	}
	public String getContent(){
		return this.content;
	}
	
	public void setId(int id){
		this.cmmt_id=id;
	}
	public void setOwner(int user){
		this.owner_id=user;
	}
	public void setAbout(int news){
		this.about_id=news;
	}
	public void setContent(String cntt){
		this.content=cntt;
	}
}
