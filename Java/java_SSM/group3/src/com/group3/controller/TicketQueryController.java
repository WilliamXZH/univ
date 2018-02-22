package com.group3.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.group3.po.Station;
import com.group3.po.TicketQueryCondition;
import com.group3.service.TicketQueryService;
import com.group3.vo.TrainVO;

import net.sf.json.JSONArray;

@Controller
public class TicketQueryController {

	@Resource
	TicketQueryService ticketQueryService;
	
	@RequestMapping("queryInfo/queryTicket")
	public void ticketQuery(String type,TicketQueryCondition condition,HttpServletResponse response,HttpSession session) throws IOException{
		System.out.println(condition);
		if(condition.getDate()!=null&&condition.getDeparture()!=null&&condition.getDestination()!=null){
			System.out.println("dep");
			
			Station dep = ticketQueryService.getStationByName(condition.getDeparture());
			System.out.println("des");
			Station des = ticketQueryService.getStationByName(condition.getDestination());
			System.out.println("no");
			if(dep!=null&&des!=null){
				
				condition.setDeparture(dep.getId().toString());
				condition.setDestination(des.getId().toString());
				System.out.println(condition);
				List<TrainVO> trains = ticketQueryService.queryTicket(condition);
				
				for(TrainVO trainVO:trains){
					trainVO.setDeparture(dep.getName());
					trainVO.setDestination(des.getName());
					//System.out.println("localRoute:"+trainVO.getLocalRoute());
					System.out.println(trainVO);
				}
				session.setAttribute(type+"Trains", trains);
				JSONArray jsonArray = JSONArray.fromObject(trains);
				response.setContentType("application/json;charset=UTF-8");
				System.out.println(jsonArray);
				response.getWriter().print(jsonArray);
				
				//System.out.println(trains);
				//session.setAttribute("trains", trains);
			}else{
				System.out.println("dep or des is not existed!");
			}
		}else{
			
		}
	}
	
}
