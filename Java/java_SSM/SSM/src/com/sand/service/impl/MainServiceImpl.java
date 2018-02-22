package com.sand.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Properties;

import javax.annotation.Resource;

import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.fs.shell.Command;
import org.junit.Test;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sand.service.MainService;
import com.sand.util.ReduceMapper.WordCountMaster;
import com.sand.util.cmd.RunCmdUtil;
import com.sand.util.hdfs.FileSystemUtil;
import com.sand.util.hdfs.HdfsUtil;
import com.sand.util.mapreduce.MapReduceParams;
import com.sand.util.properties.PropertiesUtil;
import com.sand.vo.MyDate;
import com.sand.vo.Out;
import com.sand.vo.Route;
import com.sand.vo.Person;


@Service
public class MainServiceImpl implements MainService {
	
	@Resource
	PropertiesUtil propertiesUtil;
	@Resource
	FileSystemUtil fileSystemUtil;
	@Resource
	RunCmdUtil runCmdUtil;
	@Resource
	WordCountMaster wordCountMaster;
	@Resource
	HdfsUtil hdfsUtil;

	@Override
	public boolean fileUpload(MultipartFile file) {
		String filename = file.getOriginalFilename();
		String path = propertiesUtil.readPropertyBykey("/system.properties", 
				"localPath") + File.separator + "userName";
		String dst = propertiesUtil.readPropertyBykey("/system.properties", 
				"uploadPath") + File.separator + "userName" + File.separator 
				+ filename;
		File filepath = new File(path, filename);
		if (!filepath.getParentFile().exists()) {
			filepath.getParentFile().mkdirs();
		}
		String localPath = path + File.separator + filename; 
		try{
			file.transferTo(new File(localPath));
			FileSystem fs = fileSystemUtil.getFileSystem();
			fs.copyFromLocalFile(true, true, new Path(localPath), new Path(dst));
		}catch(Exception e){
			return false;
		}
		return true;
	}

	@Override
	public boolean runMapReduce(String string) {		
		try {
			wordCountMaster.mapReduce(string);
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Override
	public boolean deleteExistDir(String string) {
		try {
			fileSystemUtil.deleteDir(string);
		} catch (Exception e) {
			return false;			
		}
		return true;
	}
	
	@Override
	public List<MyDate> hdfs(String string){
		Path path = new Path("/bigdataout/sqoop/hive/pie/part-r-00000");
		List<MyDate> result=hdfsUtil.piePicture(path);
		return result;		
	}
	
	@Override
	public List<Out> hdfs2(String string){
		Path path = new Path("/bigdataout/sqoop/hive/line/part-r-00000");
		List<Out> result2=hdfsUtil.linePicture(path);
		return result2;
	}
	
	@Override
	public List<Route> hdfs3(String string){
		Path path = new Path("/bigdataout/sqoop/hive/map/part-r-00000");
		List<Route> result2=hdfsUtil.mapPicture(path);
		return result2;
	}
	
	@Override
	public List<Person> hdfs4(String string){
		Path path = new Path("/bigdataout/sqoop/hive/point/part-r-00000");
		List<Person> result2=hdfsUtil.pointPicture(path);
		return result2;
	}
}





