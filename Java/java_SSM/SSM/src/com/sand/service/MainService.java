package com.sand.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.sand.util.mapreduce.MapReduceParams;
import com.sand.vo.MyDate;
import com.sand.vo.Out;
import com.sand.vo.Person;
import com.sand.vo.Route;

public interface MainService {
	
	public boolean fileUpload(MultipartFile file);
	
	public boolean runMapReduce(String string);	

	public boolean deleteExistDir(String string);

	public List<MyDate> hdfs(String string);

	public List<Out> hdfs2(String string);

	public List<Route> hdfs3(String string);
	
	public List<Person> hdfs4(String string);
	
}
