package com.group3.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.group3.po.Order;
import com.group3.service.OrderService;
import com.group3.util.CompareTime;
import com.group3.util.JsonDateValueProcessor;
import com.group3.vo.OrderInfo;
import com.group3.vo.OrderQueryConditionVO;

import net.sf.json.JSONArray;

@Controller
public class OrderController {

	@Resource
	OrderService orderService;

	/**
	 * @param orderConditon
	 * @param response
	 * @throws ParseException
	 * @throws IOException
	 * orderConditon.getWay()
	 * 1:按照乘车日期查询
	 * ~1:
	 */
	@SuppressWarnings("null")
	@RequestMapping("/orderWeb/selectOrder")
	public void selectOrder(@ModelAttribute OrderQueryConditionVO orderConditon,HttpServletResponse response) throws ParseException, IOException{
		List<OrderInfo> list = null;
		List<OrderInfo> list2 = new ArrayList<>();
		System.out.println(orderConditon);
		System.out.println("kan:"+orderConditon.getCondition());
		JSONArray jsonArray;
		if(orderConditon.getWay().equals("1")){
			if(orderConditon.getCondition()!=null && orderConditon.getCondition()!=""){
				list = orderService.selectOrder(orderConditon.getCondition(),
						orderConditon.getStart(),orderConditon.getEnd());
			}else{
				list = orderService.selectOrder2(
						orderConditon.getStart(), orderConditon.getEnd());
			}
		}else{
			if(orderConditon.getCondition()!=null && orderConditon.getCondition()!=""){
				list = orderService.selectOrder3(orderConditon.getCondition(),
						orderConditon.getStart(),orderConditon.getEnd());
			}else{
				list = orderService.selectOrder4(
						orderConditon.getStart(),orderConditon.getEnd());
			}
		}
		System.out.println(list);
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd");
		if(orderConditon.getType().equals("unfinished")){
			
			for (OrderInfo order : list) {
				System.out.println(order);
				int i =CompareTime.compare(order.getDepartTime());
				if(order.getPayStatus() == 0 && i==1){
					list2.add(order);					
				}
			}
		}else if(orderConditon.getType().equals("finished")){
			for (OrderInfo order : list) {
				int i =CompareTime.compare(order.getDepartTime());
				if(order.getPayStatus() == 1&&i==1){
					list2.add(order);					
				}
			}
		}else{
			for (OrderInfo order : list){
				int i =CompareTime.compare(order.getDepartTime());
				if(i==0){
					list2.add(order);					
				}
			}		
		}
		jsonArray = JSONArray.fromObject(list2,JsonDateValueProcessor.getJsonConfig());
		response.setContentType("application/json;charset=UTF-8");
		System.out.println(jsonArray);
		response.getWriter().print(jsonArray);
	}
	@RequestMapping("/orderWeb/addOrder")
	public void addOrder(@ModelAttribute Order order,HttpSession session){
		String mainUserId = (String)session.getAttribute("id");
		//seatId 如何获取？
		//
	}
	
}
