package com.neu.model;

public class CivilianMark {

	public static int NON_CIVILIAN = 0;
	public static int NATIONAL_CIVILIAN = 1;
	public static int CATA_CIVILIAN = 2;
	public static int REFER_CIVILIAN = 3;
	
	private static String []params = {"非公务员","国家公务员","依照公务员","参照公务员"};
	
	public static Integer strToInt(String param){
		for(int i=0;i<params.length;i++){
			if(param.equals(params[i])){
				return i;
			}
		}
		return 0;
	}
	
	public static String intToStr(Integer value){
		if(value>=0&&value<params.length){
			return params[value];
		}
		
		return "null";
	}
	
}
