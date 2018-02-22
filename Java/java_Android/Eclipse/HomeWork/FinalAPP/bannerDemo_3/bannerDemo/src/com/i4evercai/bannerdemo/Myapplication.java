package com.i4evercai.bannerdemo;

import java.util.ArrayList;
import java.util.List;

import android.app.Application;

public class Myapplication extends Application{
	private int times;
	private String user="visitor";
	
	private ArrayList<OrderItem> orderList=new ArrayList<OrderItem>();
	
	public String getUser(){
		return user;
	}
	public void setUser(String nm){
		user=nm;
	}
	
	public int getTimes() {
		return times;
	}
	public void setTimes(int times) {
		this.times = times;
	}
	public ArrayList<OrderItem> getOrderList() {
		return orderList;
	}
    public void onCreate()
    {
        super.onCreate();
        times=2;
    }
    
    public void toList(List<OrderItem> oc){
    	orderList.clear();
    	for(int i=0;i<oc.size();i++){
    		orderList.add(oc.get(i));
    	}
    }
	
	
}
