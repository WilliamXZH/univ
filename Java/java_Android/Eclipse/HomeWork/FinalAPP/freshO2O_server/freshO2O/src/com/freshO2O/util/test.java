package com.freshO2O.util;

import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class test {
	public static void main(String[] args) {
		Date now = new Date(); 
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String nowDate= dateFormat.format(now); 
		System.out.println(nowDate);
		DecimalFormat de=new DecimalFormat("###.#");
		double g=Double.parseDouble(de.format(3213.12312));
		System.out.println(g);
		File fi=new File("WebRoot/upload/a244.jpg");
		fi.delete();
		System.out.println(fi.exists());
	}
}
