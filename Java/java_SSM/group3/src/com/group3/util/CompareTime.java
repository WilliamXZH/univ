package com.group3.util;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;

public class CompareTime {
	//获取系统时间
	static Calendar now = Calendar.getInstance();  
    static Date systime = now.getTime();
    
    public static int compare(String x) throws ParseException{
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");  
        Date today = sdf.parse(x);
        if(today.getTime()> systime.getTime()){
        	return 1;
        }
		return 0;
        
    }


}
