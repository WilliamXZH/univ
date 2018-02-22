package pers.william.test;

import java.text.DecimalFormat;
import java.util.Random;

public class Utils {
	private static Random ran=new Random();
	private static DecimalFormat df=new DecimalFormat(".##");
	
	public static int getRandomInt(){		
		int tmp=ran.nextInt();
		return tmp<0?-tmp:tmp;
	}
	public static String getRandomDouble(){
		double d=Math.random()*2000;
		return df.format(d);
	}	
	public static String getNegRandomDouble(){
		double d=Math.random()*1000-100;
		return df.format(d);
	}
	public static String IntToChar4(int num){
		if(num<10)return "000"+num;
		else if(num<100)return "00"+num;
		else if(num<1000)return "0"+num;
		else if(num<10000)return ""+num;
		else return ""+num%10000;
	}	
	public static String IntToChar2(int num){
		if(num<10)return "0"+num;
		else if(num<100)return ""+num;
		else return ""+num%100;
	}
}
