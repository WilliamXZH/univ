package com.sand.util.hdfs;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import com.sand.vo.*;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.junit.Test;
import org.springframework.stereotype.Component;

@Component
public class HdfsUtil {

	@Resource
	FileSystemUtil fileSystemUtil;

	public List<MyDate> piePicture(Path path) {
		// 饼图
		FileSystem fs = fileSystemUtil.getFileSystem();
		System.out.println(path);
		List<MyDate> list2 = new ArrayList<MyDate>();
		try {
			FSDataInputStream dataInputStream = fs.open(path);
			InputStreamReader inputStreamReader = new InputStreamReader(dataInputStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			List<String> list = new ArrayList<String>();

			String[] aStrings;
			String string1 = null;

			while ((string1 = bufferedReader.readLine()) != null) {
				list.add(string1);
			}
			for (int i = 0; i < list.size(); i++) {
				aStrings = list.get(i).split("\t");
				MyDate tempDate = new MyDate(aStrings[0], Integer.parseInt(aStrings[1]));
				list2.add(tempDate);
			}

			String tempName = null;
			int tempValue = 0;
			// 排序
			for (int i = 0; i < list2.size(); i++) {
				for (int j = i + 1; j < list2.size(); j++) {
					if (list2.get(i).getValue() < list2.get(j).getValue()) {
						tempName = list2.get(i).getName();
						tempValue = list2.get(i).getValue();
						MyDate myDate = new MyDate(tempName, tempValue);
						list2.set(i, list2.get(j));
						list2.set(j, myDate);
					}
				}
			}
			for (int i = 0; i < list2.size(); i++) {
				System.out.println("车站：" + list2.get(i).getName());
				System.out.println("数目：" + list2.get(i).getValue());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list2;
	}

	public List<Out> linePicture(Path path) {

		// 折线图
		FileSystem fs = fileSystemUtil.getFileSystem();
		System.out.println(path);
		int value = 0;
		int jan = 0;
		int feb = 0;
		int mar = 0;
		int apr = 0;
		int may = 0;
		int jun = 0;
		int jul = 0;
		int aug = 0;
		int sept = 0;
		int oct = 0;
		int nov = 0;
		int dec = 0;
		int value2 = 0;
		int jan2 = 0;
		int feb2 = 0;
		int mar2 = 0;
		int apr2 = 0;
		int may2 = 0;
		int jun2 = 0;
		int jul2 = 0;
		int aug2 = 0;
		int sept2 = 0;
		int oct2 = 0;
		int nov2 = 0;
		int dec2 = 0;
		String years = null;
		String years2 = null;
		String mouth;
		List<String> list = new ArrayList<String>();
		List<MyDate> list21 = new ArrayList<MyDate>();
		List<MyFinal> list3 = new ArrayList<MyFinal>();
		List<Out> list4 = new ArrayList<Out>();
		String[] aStrings;
		String string1 = null;
		try {
			FSDataInputStream dataInputStream = fs.open(path);
			InputStreamReader inputStreamReader = new InputStreamReader(dataInputStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
			while ((string1 = bufferedReader.readLine()) != null) {
				list.add(string1);
			}
			for (int i = 0; i < list.size(); i++) {
				aStrings = list.get(i).split("\t");
				MyDate tempDate = new MyDate(aStrings[0], Integer.parseInt(aStrings[1]));
				list21.add(tempDate);
			}
			for (int i = 0; i < list21.size(); i++) {
				years = list21.get(i).getName().substring(0, 4);
				mouth = list21.get(i).getName().substring(4);
				value = list21.get(i).getValue();
				MyFinal myFinal = new MyFinal(years, mouth, value);
				list3.add(myFinal);
			}
			MyFinal myFinal = new MyFinal();
			for (int i = 0; i < list3.size(); i++) {
				myFinal = list3.get(i);
				if (myFinal.getYears().equals("2016")) {
					// Out out = new Out();
					years = myFinal.getYears();
					if (myFinal.getMouth().equals("01")) {
						jan = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("02")) {
						feb = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("03")) {
						mar = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("04")) {
						apr = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("05")) {
						may = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("06")) {
						jun = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("07")) {
						jul = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("09")) {
						sept = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("10")) {
						oct = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("11")) {
						nov = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("12")) {
						dec = myFinal.getVaule();
					} else {
						aug = myFinal.getVaule();
					}
				} else {
					years2 = myFinal.getYears();
					if (myFinal.getMouth().equals("01")) {
						jan2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("02")) {
						feb2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("03")) {
						mar2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("04")) {
						apr2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("05")) {
						may2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("06")) {
						jun2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("07")) {
						jul2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("09")) {
						sept2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("10")) {
						oct2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("11")) {
						nov2 = myFinal.getVaule();
					} else if (myFinal.getMouth().equals("12")) {
						dec2 = myFinal.getVaule();
					} else {
						aug = myFinal.getVaule();
					}

				}
			}
			Out out = new Out(years, jan, feb, mar, apr, may, jun, jul, aug, sept, oct, nov, dec);
			Out out2 = new Out(years2, jan2, feb2, mar2, apr2, may2, jun2, jul2, aug2, sept2, oct2, nov2, dec2);
			list4.add(out);
			list4.add(out2);

			for (int i = 0; i < list4.size(); i++) {
				System.out.println(list4.get(i).toString());
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return list4;

	}

	public List<Person> pointPicture(Path path) {
		List<String> list = new ArrayList<String>();
		List<MyDate> list2 = new ArrayList<MyDate>();
		List<Person> list3 = new ArrayList<Person>();

		String[] bStrings;
		String[] aStrings;
		String string = null;
		FileSystem fs = fileSystemUtil.getFileSystem();
		System.out.println(path);
		try {

			FSDataInputStream dataInputStream = fs.open(path);
			InputStreamReader inputStreamReader = new InputStreamReader(dataInputStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			while ((string = bufferedReader.readLine()) != null) {
				list.add(string);
			}
			for (int i = 0; i < list.size(); i++) {
				aStrings = list.get(i).split("\t");
				MyDate tempDate = new MyDate(aStrings[0], Integer.parseInt(aStrings[1]));
				list2.add(tempDate);
			}

			for (int i = 0; i < list2.size(); i++) {
				bStrings = list2.get(i).getName().split("-");
				Person persontem = new Person(bStrings[0], bStrings[1], list2.get(i).getValue());
				list3.add(persontem);
			}
			for (int i = 0; i < list3.size(); i++) {
				System.out.println(list3.get(i).toString());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list3;
	}

	public List<Route> mapPicture(Path path) {
		List<String> list = new ArrayList<String>();
		List<MyDate> list2 = new ArrayList<MyDate>();
		List<Route> list3 = new ArrayList<Route>();

		String[] bStrings;
		String[] aStrings;
		String string = null;
		FileSystem fs = fileSystemUtil.getFileSystem();
		System.out.println(path);
		try {

			FSDataInputStream dataInputStream = fs.open(path);
			InputStreamReader inputStreamReader = new InputStreamReader(dataInputStream, "UTF-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			while ((string = bufferedReader.readLine()) != null) {
				list.add(string);
			}
			/*
			 * for(int i=0;i<list.size();i++){ System.out.println(list.get(i));
			 * }
			 */
			for (int i = 0; i < list.size(); i++) {
				aStrings = list.get(i).split("\t");
				MyDate tempDate = new MyDate(aStrings[0], Integer.parseInt(aStrings[1]));
				list2.add(tempDate);
			}
			/*
			 * for(int i=0;i<list2.size();i++){
			 * System.out.println(list2.get(i).name);
			 * System.out.println(list2.get(i).value); }
			 */
			for (int i = 0; i < list2.size(); i++) {
				bStrings = list2.get(i).getName().split("-");
				Route routetem = new Route(bStrings[0], bStrings[1], list2.get(i).getValue());
				list3.add(routetem);
			}
			for (int i = 0; i < list3.size(); i++) {
				System.out.println(list3.get(i).toString());
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list3;
	}

}
