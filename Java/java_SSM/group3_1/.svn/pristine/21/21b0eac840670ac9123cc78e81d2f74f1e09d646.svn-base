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
	public List<OrderInfo> selectOrder(String condition,String start,String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("condition", condition);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder(map);
	    return list;
	}

	@Override
	public List<OrderInfo> selectOrder2(String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder2(map);
		return list;
	}

	@Override
	public List<OrderInfo> selectOrder3(String condition, String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("condition", condition);
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder3(map);
	    return list;
	}

	@Override
	public List<OrderInfo> selectOrder4(String start, String end) {
		Map<String,String> map = new HashMap<>(); 
		map.put("start", start);
		map.put("end", end);
		List<OrderInfo> list = orderMapper.selectOrder4(map);
		return list;
	}

	@Override
	public boolean addOrder(Order newOrder) {
		int flag = orderMapper.addOrder(newOrder);
		if(flag != 0){
			return true;
		}
		return false;
	}
}
