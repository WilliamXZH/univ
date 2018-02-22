package com.neu.util;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.neu.model.po.PersonPO;

public class fileUtil {
	
	@Test
	public void test(){
		System.out.println("test!!!");
		List<PersonPO> list = readDataFile();
		System.out.println(list);
		for(int i=0;i<list.size();i++){
			System.out.println(list.get(i));
		}
	}

	public List<PersonPO> readDataFile(){
		List<PersonPO> list = new ArrayList<>();
		try {
			String relativelyPath=System.getProperty("user.dir");
			System.out.println(relativelyPath);
			BufferedReader br = new BufferedReader(
					new InputStreamReader(new FileInputStream(relativelyPath+"/src/personnel.dat")));
			String item = null;
			try {
				while((item = br.readLine())!=null){
					System.out.println(item+":"+item.split(" ").length);
					list.add(new PersonPO(item));
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return list;
	}
	
	public boolean saveAsFile(List<PersonPO> data){
		return false;
	}
}
