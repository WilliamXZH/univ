package com.group3.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.SeatMapper;
import com.group3.po.SeatInfo;
import com.group3.po.SeatQueryCondition;
import com.group3.service.SeatService;

@Service
public class SeatServiceImpl implements SeatService {
	
	@Resource
	SeatMapper seatMapper;
	@Override
	public List<SeatInfo> allocSeat(SeatQueryCondition condition) {
		List<SeatInfo> list = seatMapper.allocSeat(condition);
		Integer[] routeIds = seatMapper.selectRouteIds(condition);//从出发地到目的地的路径id数组
		for(SeatInfo seat:list){
			String idsStr="";
			for(Integer rid : routeIds){
				Integer seatId = seatMapper.selectSeatId(seat.getCarriageId(), seat.getNum(), rid);//获取座位id
				idsStr += ("/"+seatId+"/");//座位id拼接
				seat.setIds(idsStr);//设置返回的seat对象的座位id序列
				if(seatMapper.updateSeatStatus(seatId,0)>0){//将涉及到的每段的每个座位的状态修改为0
					seat.setStatus(0);//设置返回的seat对象的status为0
				}
				seat.setId(seatId);//随便取一个seatId
			}
			System.out.println(seat.getNum()+"idsStr:"+idsStr);
		}
		return list;
	}

}
