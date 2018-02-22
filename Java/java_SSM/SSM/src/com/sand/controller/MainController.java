package com.sand.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.avro.data.Json;
import org.junit.Test;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.sand.service.MainService;
import com.sand.vo.MyDate;
import com.sand.vo.Out;
import com.sand.vo.Person;
import com.sand.vo.Route;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
public class MainController {

	@Resource
	private MainService mainService;

	@RequestMapping("/main/fileUpload")
	public String fileUpload(MultipartFile file) {
		if (!file.isEmpty()) {
			// 上传文件路径
			boolean result = mainService.fileUpload(file);
			if (result) {
				return "main/success";
			} else {
				return "main/error";
			}
		} else {
			return "main/error";
		}
	}

	@RequestMapping("/bigdata/dataStatistics")
	public void runDataStatistics(String picture, HttpServletResponse response) throws Exception {
		
		if (picture.equals("pie_picture")) {
			//删除已存在的统计文件
			mainService.deleteExistDir("pie_picture");
			//MAPREDUCE生成新的统计文件
			boolean result = mainService.runMapReduce(picture);
			if (result) {
				//将统计文件拆分成前段需要的数据
				List<MyDate> result3 = mainService.hdfs(picture);
				System.out.println(result3);

				//使用AJAX发送数据到前端
				JSONArray jsonArray = JSONArray.fromObject(result3);
				response.setContentType("application/json;charset=utf-8");
				System.out.println("json:" + jsonArray);
				response.getWriter().print(jsonArray);
			}else {
			}
		} else if (picture.equals("line_picture")) {
			mainService.deleteExistDir("line_picture");
			boolean result = mainService.runMapReduce(picture);
			if (result) {
				List<Out> result3 = mainService.hdfs2(picture);
				System.out.println(result3);
				JSONArray jsonArray = JSONArray.fromObject(result3);
				response.setContentType("application/json;charset=utf-8");
				System.out.println("json:" + jsonArray);
				response.getWriter().print(jsonArray);
			}
		}else if (picture.equals("map_picture")) {
			mainService.deleteExistDir("map_picture");
			boolean result = mainService.runMapReduce(picture);
			if (result) {
				List<Route> result3 = mainService.hdfs3(picture);
				System.out.println(result3);
				JSONArray jsonArray = JSONArray.fromObject(result3);
				response.setContentType("application/json;charset=utf-8");
				System.out.println("json:" + jsonArray);
				response.getWriter().print(jsonArray);
			}
		}else if (picture.equals("point_picture")) {
			mainService.deleteExistDir("point_picture");
			boolean result = mainService.runMapReduce(picture);
			if (result) {
				List<Person> result3 = mainService.hdfs4(picture);
				System.out.println(result3);
				JSONArray jsonArray = JSONArray.fromObject(result3);
				response.setContentType("application/json;charset=utf-8");
				System.out.println("json:" + jsonArray);
				response.getWriter().print(jsonArray);
			}
		}
		}
	
}
