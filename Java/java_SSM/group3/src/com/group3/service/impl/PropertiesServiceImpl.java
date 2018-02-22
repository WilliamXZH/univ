package com.group3.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.stereotype.Service;

import com.group3.util.PropertiesUtil;


@Service
public class PropertiesServiceImpl implements com.group3.service.PropertiesService {

	@Resource
	private PropertiesUtil propertiesUtil;
	
	
	
	@Test
	public void test(){
		propertiesUtil = new PropertiesUtil();
		for(int liv_i=0;liv_i<12;liv_i++){
			System.out.println(getTicketTypeQuot(liv_i));
		}
		
		String []ticketTypes={"商务座","一等座","二等座","高级软卧","软卧",
				"动卧","硬卧","软座","硬座","无座"};
		for(int liv_j=0;liv_j<ticketTypes.length;liv_j++){
			System.out.println(getTicketTypeQuot(ticketTypes[liv_j]));
		}
		System.out.println();
		String []userTypes={"成人","学生","儿童","军人","残疾人"};
		for(int liv_k=0;liv_k<userTypes.length;liv_k++){
			System.out.println(getUserTypeQuot(userTypes[liv_k]));
		}
		System.out.println(getUserTypeQuot(""));
		
	}
	
	@Override
	public Float getTicketTypeQuot(Integer ticketTypeId) {
		Properties properties = propertiesUtil.getProperties("/quotiety.properties");
		
		String []tickets={"business_seat_quot","first_class_quot",
				"second_class_quot","high_grade_soft_berth_quot",
				"oridinary_soft_berth_quot","pneumatic_horizontal_quot",
				"hard_sleeper_quot","soft_seat_quot",
				"hard_seat_quot","none_seat_quot"};
		if(ticketTypeId<=0||ticketTypeId>tickets.length){
			return (float) 1.0;
		}else{
			return Float.parseFloat(properties.getProperty(tickets[ticketTypeId-1]));
		}
		
	}

	@Override
	public Float getTicketTypeQuot(String ticketType) {
		Map<String,Integer> ticketTypes = new HashMap<>();
		ticketTypes.put("商务座", 1);
		ticketTypes.put("一等座", 2);
		ticketTypes.put("二等座", 3);
		ticketTypes.put("高级软卧", 4);
		ticketTypes.put("软卧", 5);
		ticketTypes.put("动卧", 6);
		ticketTypes.put("硬卧", 7);
		ticketTypes.put("软座", 8);
		ticketTypes.put("硬座", 9);
		ticketTypes.put("无座", 10);
		
		return getTicketTypeQuot(ticketTypes.get(ticketType));
	}

	@Override
	public Float getUserTypeQuot(String userType) {
		Map<String, String> userTypes = new HashMap<>();
		userTypes.put("成人", "adult_passenger_quot");
		userTypes.put("学生", "student_passenger_quot");
		userTypes.put("儿童", "child_passenger_quot");
		userTypes.put("军人", "military_passenger_quot");
		userTypes.put("残疾人", "disabled_passenger_quot");
		Properties properties = propertiesUtil.getProperties("/quotiety.properties");
		String quot_name = userTypes.get(userType);
		if(quot_name==null){
			return (float) 1.0;
		}
		return Float.parseFloat(properties.getProperty(quot_name));
	}

}
