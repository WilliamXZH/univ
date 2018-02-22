package com.sand.util.hdfs;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.springframework.stereotype.Component;
import org.apache.hadoop.fs.Path;
import org.junit.Test;

import com.sand.util.properties.PropertiesUtil;

@Component
public class FileSystemUtil {
	
	private static Configuration conf = new Configuration();
	private static FileSystem fs;

	static {
		try {
			PropertiesUtil propertiesUtil = new PropertiesUtil();
			FileSystem.setDefaultUri(conf, 
					propertiesUtil.readPropertyBykey("/system.properties", 
							"HADOOP_URL"));
			fs = FileSystem.get(conf);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static FileSystem getFileSystem(){
		return fs;
	}

	public void deleteDir(String string)throws Exception{
		if(string.equals("pie_picture")){
			fs.delete(new Path("hdfs://whn01:8020/bigdataout/sqoop/hive/pie"),true);
			System.out.println("1");
		}else if(string.equals("line_picture")) {
			fs.delete(new Path("hdfs://whn01:8020/bigdataout/sqoop/hive/line"),true);
			System.out.println("2");
		}else if(string.equals("map_picture")){
			fs.delete(new Path("hdfs://whn01:8020/bigdataout/sqoop/hive/map"),true);
			System.out.println("3");
		}else {
			fs.delete(new Path("hdfs://whn01:8020/bigdataout/sqoop/hive/point"),true);
			System.out.println("4");
		}
	}

}
