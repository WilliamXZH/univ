package com.group3.service;

import java.util.List;

import com.group3.po.Order;
import com.group3.vo.OrderInfo;


public interface OrderService {
	
	public List<OrderInfo> selectOrder(String id, String condition,String start,String end);

	public List<OrderInfo> selectOrder2(String id, String start, String end);

	public List<OrderInfo> selectOrder3(String id, String condition, String start, String end);

	public List<OrderInfo> selectOrder4(String id, String start, String end);
	
	public int addOrder(Order newOrder);
	
	public boolean payForOrder(Integer orderId, String payMethod, Integer ifDeliver);

}
