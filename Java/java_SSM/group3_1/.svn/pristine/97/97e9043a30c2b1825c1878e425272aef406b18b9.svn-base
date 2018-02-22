package com.group3.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Properties;

import org.springframework.stereotype.Component;


@Component
public class PropertiesUtil {

	public String readPropertyByKey(String url,String key){
		InputStream inputStream = this.getClass().getResourceAsStream(url);
		BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
		Properties properties = new Properties();
		
		try {
			properties.load(reader);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if("null".equals(properties.getProperty(key))
				||properties.getProperty(key)==null){
			return "null";
		}else{
			return properties.getProperty(key);
		}
		
		
	}
	
	public Properties getProperties(String url){
		InputStream inputStream = this.getClass().getResourceAsStream(url);
		BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
		Properties properties = new Properties();
		try {
			properties.load(reader);
			return properties;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		
		
		
	}
	
}
