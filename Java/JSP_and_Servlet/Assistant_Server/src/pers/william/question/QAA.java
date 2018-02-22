package pers.william.question;

public class QAA {
	private int id;
	private int type;
	private String question;
	private String answer;
	
	public QAA(String que,String ans){
		this(0,que,ans);
	}
	public QAA(int ty,String que,String ans){
		this(0,ty,que,ans);
	}
	public QAA(int id,int ty,String que,String ans){
		this.id=id;
		this.type=ty;
		this.question=que;
		this.answer=ans;
	}
	
	public int getId(){
		return this.id;
	}
	public int getType(){
		return this.type;
	}
	public String getQuestion(){
		return this.question;
	}
	public String getAnswer(){
		return this.answer;
	}
	
	public void stId(int id){
		this.id=id;
	}
	public void setType(int ty){
		this.type=ty;
	}
	public void setQuestion(String que){
		this.question=que;
	}
	public void setAnswer(String ans){
		this.answer=ans;
	}
	public String toString(){
		return id+"_"+type+"_"+question+"_"+answer;
	}
}
