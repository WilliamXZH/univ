package pers.william.news;

import java.util.ArrayList;
import java.util.List;

public class NewsContainer {

	private int total=0;
	private List<News> news=new ArrayList<News>();
	
	public void add(News nws){
		news.add(nws);
		total++;
	}
	public void add(int typ,String title,String cont){
		this.add(-1,0,typ,title,cont);
	}
	public void add(int id,int tms,int typ,String title,String cont){
		this.add(id,tms,typ,title,null,cont);
	}
	public void add(int id,int tms,int typ,String title,String pic,String cont){
		this.add(false,false,id,tms,typ,title,pic,cont);
	}
	public void add(boolean hot,boolean top,int id,int tms,int typ,String title,String pic,String cont){
		this.add(new News(hot,top,id,tms,typ,title,pic,cont));
	}	
	public int size(){
		return this.total;
	}	
	public News get(int i){
		return news.get(i);
	}
	public List<News> getContainer(){
		return this.news;
	}
}
