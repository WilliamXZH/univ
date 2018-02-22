package pers.william.service;

import java.util.ArrayList;
import java.util.List;

public class OrderContainer {
	int total=0;
	List<OrderItem> ois=new ArrayList<OrderItem>();
	
	public void addOrder(String tostr){
		total++;
		ois.add(new OrderItem(tostr));
	}
	
	public int size(){
		return total;
	}
	public List<OrderItem> deString(String str){
		
		if(!str.equals("")&&str!=null){
			String orders[]=str.split("@");
			for(int i=0;i<orders.length;i++)
				addOrder(orders[i]);
		}
		return ois;
	}
	public String toString(){
		String tmp="";
		for(int i=0;i<total;i++){
			if(i==0)tmp+=ois.get(i).toString();
			else tmp+="@"+ois.get(i).toString();
		}
		return tmp;
	}
}
