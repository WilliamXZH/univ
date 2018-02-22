package com.freshO2O.util;

import java.util.HashMap;
import java.util.Map;

public class PageUtil {
	public static Map<String, Integer> pageMap(String num,int count,int pageSize){
		int pageNow=0;
		Map<String, Integer> map=new HashMap<String, Integer>();
		if (num==null||num.equals("0")) {
			num="1";
		}
		int pageCount=(count%pageSize==0)?(count/pageSize):(count/pageSize+1);
		pageNow=Integer.parseInt(num);
		if (pageNow<=0) {
			pageNow=1;
		}else if (pageNow>pageCount&&pageCount>0) {
			pageNow=pageCount;
		}
		int pageUp=pageNow-1;
		int pageDown=pageNow+1;
		if (pageNow<=1) {
			pageUp=1;
		}
		if (pageNow>=pageCount) {
			pageDown=pageCount;
		}
		int pageStart=(pageNow-1)*pageSize;
		map.put("pageStart", pageStart);
		map.put("pageSize", pageSize);
		map.put("pageNow", pageNow);
		map.put("pageCount", pageCount);
		map.put("pageUp", pageUp);
		map.put("pageDown", pageDown);
		return map;
	}
}
