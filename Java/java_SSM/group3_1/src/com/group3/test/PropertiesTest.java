package com.group3.test;


import org.junit.Test;

import com.group3.service.PropertiesService;
import com.group3.service.impl.PropertiesServiceImpl;

public class PropertiesTest {

	
	
	@Test
	public void test(){
		PropertiesService propertiesService = new PropertiesServiceImpl();
		System.out.println(propertiesService.getTicketTypeQuot(3));
	}
	
}
