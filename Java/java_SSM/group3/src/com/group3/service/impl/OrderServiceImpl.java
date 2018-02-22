package com.group3.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.OrderMapper;
import com.group3.po.Order;
import com.group3.service.OrderService;
import com.group3.vo.OrderInfo;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Resource
	OrderMapper orderMapper;
	
	@Override
	public List<OrderInfo> selectOrder(String id, String condition,String start,String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("userId",id);
		map.put("condition", condition);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder(map);
	    return list;
	}

	@Override
	public List<OrderInfo> selectOrder2(String id, String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("userId",id);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder2(map);
		return list;
	}

	@Override
	public List<OrderInfo> selectOrder3(String id, String condition, String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("userId",id);
		map.put("condition", condition);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder3(map);
	    return list;
	}

	@Override
	public List<OrderInfo> selectOrder4(String id, String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("userId",id);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder4(map);
		return list;
	}

	@Override
	public int addOrder(Order newOrder) {
		int id = -1;
		Map<String,Object> paramMap = new HashMap<String,Object>();
		paramMap.put("userId", newOrder.getUserId());
		paramMap.put("memberName", newOrder.getMemberName());
		paramMap.put("seatId", newOrder.getSeatId());
		paramMap.put("depatureId", newOrder.getDepatureId());
		paramMap.put("destinationId", newOrder.getDestinationId());
		paramMap.put("cost", newOrder.getCost());
		paramMap.put("trainId", newOrder.getTrainId());
		paramMap.put("departTime", newOrder.getDepartTime());
		paramMap.put("seatIds", newOrder.getSeatIds());
		paramMap.put("NEWID", -1);
		/*int flag = orderMapper.addOrder(newOrder);
		if(flag != 0){
			id = orderMapper.selectCurrentOrderId();	
		}*/
		orderMapper.selectCurrentOrderId(paramMap);
		if((Integer)paramMap.get("NEWID") != -1){
			id = (Integer)paramMap.get("NEWID");
		}
		System.out.println("OrderServiceImpl(paramMap):"+paramMap);
		return id;
	}
	
	@Override
	public boolean payForOrder(Integer orderId,String payMethod,Integer ifDeliver){
		boolean flag = false;
		if(orderMapper.payForOrder(orderId,payMethod,ifDeliver)==1){
			flag = true;
		}
		return flag;
	}
}
