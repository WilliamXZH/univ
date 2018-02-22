package com.group3.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.group3.po.Station;
import com.group3.po.Time;
import com.group3.po.Train;
import com.group3.service.QueryForStationService;
import com.group3.service.QueryForTrainInfoService;
import com.group3.service.TimeService;
import com.group3.vo.TrainForBL;
import com.group3.vo.resultOfTrainQuery;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
/**
 * 
 * @author DLETC
 *
 */
@Controller
public class QueryForTrainInfoController {
	
	@Resource
	QueryForTrainInfoService queryForTrainInfoService;
	@Resource
	QueryForStationService queryForStationService;
	@Resource
	TimeService timeService;
	@RequestMapping("/queryInfo/queryTrainInfo")
	public void queryForTrainInfo(@ModelAttribute Train trainForBL,HttpServletResponse response) throws IOException{
		String errorInfo="";
		Map<String,Object> jsonMap = new HashMap<>();
		System.out.println("Ajax param:"+trainForBL);//
		if(trainForBL.getSerialNum() == "" || trainForBL.getSerialNum() == null 
				|| trainForBL.getBdDate() == "" || trainForBL.getBdDate() == null){
			errorInfo += "车次或日期为空\n";
			System.out.println(errorInfo);
		}else{
			Train requiredTrain = queryForTrainInfoService.queryForTrainInfo(trainForBL);
			System.out.println("controller train:"+requiredTrain);//
			if(requiredTrain == null){
				errorInfo += "该车次不存在\n";
				System.out.println(errorInfo);
			}else{
				List<resultOfTrainQuery> resultList = new ArrayList<>();
				String entireRoute = requiredTrain.getEntireRoute();
				entireRoute = entireRoute.substring(1, entireRoute.length()-1);
				System.out.println("全路径："+entireRoute);//
				StringTokenizer st = new StringTokenizer(entireRoute, "//");
				while(st.hasMoreTokens()){
					int stationId = Integer.parseInt(st.nextToken());
					Station station=queryForStationService.queryForStation(stationId);
					System.out.println("controller station:"+station);
					if(station == null){
						errorInfo += ("车站"+stationId+"不存在\n");
						System.out.println(errorInfo);
						continue;
					}
					Time requiredTime = timeService.queryArvAndLvTime(requiredTrain.getId(), station.getId());
					System.out.println("controller timeInfo:"+requiredTime);
					if(requiredTime == null){
						errorInfo += ("车次"+requiredTrain+"的车站"+stationId+"的时间信息不存在\n");
						System.out.println(errorInfo);
						continue;
					}
					resultList.add(new resultOfTrainQuery(station,requiredTime.getArvTime(),requiredTime.getLvTime()));
				}
				for (resultOfTrainQuery r : resultList) {
					System.out.println(r);
				}//
				jsonMap.put("resultList", resultList);
			}
		}
		jsonMap.put("errorInfo", errorInfo);
		JSONObject jsonObject = JSONObject.fromObject(jsonMap);
		response.setContentType("application/json;charset=UTF-8");
		System.out.println(jsonObject);//
		response.getWriter().print(jsonObject);
	}
}
