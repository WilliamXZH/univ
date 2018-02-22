package com.example.android_question;

import java.util.ArrayList;
import java.util.List;

public class Container {
	private List<QAA> qas=new ArrayList<QAA>();
	
	public List<QAA> Query(String keyword){
		List<QAA> tem=new ArrayList<QAA>();
		
		for(QAA qa:qas){
			if(qa.getQuestion().contains(keyword)||qa.getAnswer().contains(keyword)){
				tem.add(qa);
			}
		}
		return  tem;
	}
	
	public void add(String que,String ans){
		this.add(0, que,ans);
	}
	public void add(int ty,String que,String ans){
		qas.add(new QAA(ty,que,ans));
	}
	
}
