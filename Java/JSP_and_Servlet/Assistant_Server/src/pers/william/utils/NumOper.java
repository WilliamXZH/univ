package pers.william.utils;


import java.util.Random;

public class NumOper {
	private static Random ran=new Random();
	public static int getRandom(){
		return ran.nextInt();
	}
	public static int getRandom(int min,int max){
		int tem=getPosRandom();
		return tem%(max-min)+min;
	}
	public static int getPosRandom(){
		int tem=getRandom();
		return tem<0?-tem:tem;
	}
	public static int getNegRandom(){
		int tem=getRandom();
		return tem<0?tem:-tem;
	}
	public static int getRandomId(){
		return getRandom(0,99999);
	}
}
