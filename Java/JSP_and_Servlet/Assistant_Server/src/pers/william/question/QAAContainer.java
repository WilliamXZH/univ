package pers.william.question;

import java.util.ArrayList;
import java.util.List;

public class QAAContainer {
	private int total=0;
	private List<QAA> qas=new ArrayList<QAA>();
	
	public void add(QAA qaa){
		qas.add(qaa);
		total++;
	}
	public void add(String que){
		this.add(que,null);
	}
	public void add(String que,String ans){
		this.add(0, que,ans);
	}
	public void add(int ty,String que,String ans){
		this.add(total,ty,que,ans);
	}
	public void add(int id,int ty,String que,String ans){
		this.add(new QAA(ty,que,ans));
	}
	
	public int size(){
		return this.total;
	}
	
	public QAA get(int i){
		return qas.get(i);
	}
	public List<QAA> getContainer(){
		return this.qas;
	}
	public String toString(){
		String tmp="";
		for(int i=0;i<total;i++){
			tmp+=qas.get(i).toString()+"@";
		}
		return tmp;
	}
	
}
