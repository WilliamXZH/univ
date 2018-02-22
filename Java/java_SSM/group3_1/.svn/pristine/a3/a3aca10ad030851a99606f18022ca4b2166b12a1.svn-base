package com.group3.service.impl;

import java.util.List;

import javax.annotation.Resource;
import javax.annotation.processing.SupportedAnnotationTypes;

import org.springframework.stereotype.Service;

import com.group3.mapper.QueryForTicketMapper;
import com.group3.mapper.StationMapper;
import com.group3.mapper.TicketMapper;
import com.group3.mapper.TimeMapper;
import com.group3.po.Station;
import com.group3.po.TicketQuantityCondition;
import com.group3.po.TicketQueryCondition;
import com.group3.po.Time;
import com.group3.service.TicketQueryService;
import com.group3.vo.TicketVO;
import com.group3.vo.TrainVO;


@Service
public class TicketQueryServiceImpl implements TicketQueryService{

	@Resource
	QueryForTicketMapper queryForTicketMapper;
	@Resource
	StationMapper stationMapper;
	@Resource
	TicketMapper ticketMapper;
	@Resource
	TimeMapper timeMapper;
	
	@Override
	public List<TrainVO> queryTicket(TicketQueryCondition condition) {
		
		System.out.println("Prepare to query Trains.");
		List<TrainVO> trains = queryForTicketMapper.queryTicketsByCondition(condition);
		System.out.println("End to query Trains.");
		
		TicketQuantityCondition condition2 = new TicketQuantityCondition(condition.getDeparture(),condition.getDestination());
			
		for(TrainVO trainVO:trains){
			condition2.setTrainId(trainVO.getId());
			
			
			List<TicketVO> tickets = ticketMapper.selectTicketsByTrainIdAndTicketTypes(trainVO.getId(), condition.getTicketTypes());
			//ticketMapper.selectTicketsByTrainId(trainVO.getId());
			
			for(TicketVO ticketVO:tickets){
				
				condition2.setTicketTypeId(ticketVO.getTicketTypeId());
				
				Integer count = ticketMapper.getTicketQuantity(condition2);
				System.out.println("count:" +count);
				ticketVO.setQuantity(count);
				
				Float price = ticketMapper.getTicketPrice(condition2);
				ticketVO.setPrice(price);
			}
//			System.out.println("Tickets:");
//			System.out.println(tickets);
//			System.out.println();
			
			trainVO.setTickets(tickets);
			//System.out.println(trainVO);
			
			int trainId = trainVO.getId();
			int stationId = Integer.parseInt(condition.getDeparture());
			
			System.out.println("trainId:"+trainId+"\t"+"stationId:"+stationId);
			
			Time time1 = timeMapper.selectArvAndLvTime(trainId,stationId);
			stationId = Integer.parseInt(condition.getDestination());
			Time time2 = timeMapper.selectArvAndLvTime(trainId,stationId);
			
			String hms1[] = time2.getArvTime().split(" ")[1].split(":");
			trainVO.setArvTime(hms1[0]+":"+hms1[1]);
			
			String hms2[] = time1.getLvTime().split(" ")[1].split(":");
			trainVO.setLvTime(hms2[0]+":"+hms2[1]);
			
			Integer minutes = timeMapper.getDifferByTrainAndStation(trainId, Integer.parseInt(condition.getDeparture()), 
					Integer.parseInt(condition.getDestination()));
			System.out.println("minutes:"+minutes);
			trainVO.setTotalTime(minutes/60+"小时"+minutes%60+"分钟");
			
			
			
		}
		
		return trains;
	}

	@Override
	public Station getStationByName(String name) {
		
		return stationMapper.selectStationByName(name);
	}

	
	
}
