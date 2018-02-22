package pers.william.news;

public class News {
	private boolean isHot;
	private boolean isTop;
	private int news_id;
	private int times;
	private int type;
	private String title;
	private String news_picture;
	private String news_content;
	
	public News(int typ,String title,String cont){
		this(-1,0,typ,title,cont);
	}
	public News(int id,int tms,int typ,String title,String cont){
		this(id,tms,typ,title,null,cont);
	}
	public News(int id,int tms,int typ,String title,String pic,String cont){
		this(false,false,id,tms,typ,title,pic,cont);
	}
	public News(boolean hot,boolean top,int id,int tms,int typ,String title,String pic,String cont){
		this.isHot=hot;
		this.isTop=top;
		this.news_id=id;
		this.type=typ;
		this.title=title;
		this.news_picture=pic;
		this.news_content=cont;
	}
	
	
	public boolean getIsHot(){
		return this.isHot;
	}
	public boolean getIsTop(){
		return this.isTop;
	}
	public int getId(){
		return this.news_id;
	}
	public int getTimes(){
		return this.times;
	}
	public int getType(){
		return this.type;
	}
	public String getTitle(){
		return this.title;
	}
	public String getPicture(){
		return this.news_picture;
	}
	public String getContent(){
		return this.news_content;
	}
	
	public void setIsHot(boolean hot){
		this.isHot=hot;
	}
	public void setIsTop(boolean top){
		this.isTop=top;
	}
	public void setId(int id){
		this.news_id=id;
	}
	public void setTimes(int tms){
		this.times=tms;
	}
	public void setType(int typ){
		this.type=typ;
	}
	public void setTitle(String title){
		this.title=title;
	}
	public void setPicture(String pic){
		this.news_picture=pic;
	}
	public void setContent(String cont){
		this.news_content=cont;
	}
}
