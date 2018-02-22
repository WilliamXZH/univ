package com.group3.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeDiffer {
	/**
	 * 计算小时及以下
	 * @param arvTime
	 * @param leaveTime
	 */
	public static String timeDiff(String arvTime,String leaveTime) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time="";
		try {
			Date d1 = df.parse(arvTime);
			Date d2 = df.parse(leaveTime);
			long diff = d2.getTime() - d1.getTime();// 这样得到的差值是微秒级别
			long hours = diff / (1000 * 60 * 60);
			long minutes = (diff - hours * (1000 * 60 * 60)) / (1000 * 60);
			long seconds = (diff - hours * (1000 * 60 * 60) - minutes * (60 * 1000)) / 1000 ; 
			if(hours == 0){
				time = minutes + "分" + seconds + "秒";
			}else{
				time = hours + "小时" + minutes + "分" + seconds + "秒";
			}
		} catch (Exception e) {
			e.printStackTrace();
			
		}
		return time;
	}
}
