package com.group3.controller;

import java.io.IOException;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.group3.po.Agency;
import com.group3.service.AgencyService;

import net.sf.json.JSONArray;



@Controller
public class AgencyController {
	
	@Resource
	AgencyService agencyService;
	
	@RequestMapping("/queryInfo/agencySelect")
	public void agencySelect(HttpServletRequest request,HttpServletResponse response) throws IOException{
		String province = request.getParameter("province");
		String city = request.getParameter("city");
		String county = request.getParameter("county");
		String address = "";
		if(!province.equals("省份")){
			address += province;
			if(!city.equals("地级市")){
				address += city;
				if(!county.equals("县/县级市")){
					address += county;
				}
			}
		}
		List<Agency> list = agencyService.agencySelect(address);
		for (Agency agency : list) {
			System.out.println(agency);
		}
		JSONArray jsonArray = JSONArray.fromObject(list);
        response.setContentType("application/json;charset=UTF-8");
        System.out.println(jsonArray);
        response.getWriter().print(jsonArray);
	}

}
