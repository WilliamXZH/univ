package com.example.android_question;

public class QAA {
	private int type;
	private String question;
	private String answer;
	
	QAA(String que,String ans){
		this(0,que,ans);
	}
	
	QAA(int ty,String que,String ans){
		this.type=ty;
		this.question=que;
		this.answer=ans;
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
	
	public void setType(int ty){
		this.type=ty;
	}
	public void setQuestion(String que){
		this.question=que;
	}
	public void setAnswer(String ans){
		this.answer=ans;
	}
}
