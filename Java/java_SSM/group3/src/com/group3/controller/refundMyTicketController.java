package com.group3.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.group3.service.RefundTicketService;
import com.group3.vo.OrderVO;

import net.sf.json.JSONObject;

@Controller
public class refundMyTicketController {
	@Resource
	RefundTicketService refundTicketService;
	
	
	@RequestMapping("/myticket/refundticketqqwe")
	public void refundmyticket2(String orderNum, HttpSession session,HttpServletResponse response) throws IOException{
		OrderVO myOrder= refundTicketService.showMyOrder(orderNum);
		System.out.println(myOrder);
		response.setContentType("application/json;charset=utf-8");
		JSONObject jsonObject = JSONObject.fromObject(myOrder);
		System.out.println("json:"+jsonObject);
		response.getWriter().print(jsonObject);
	}

	@RequestMapping("/myticket/refundticket")
	public String refundmyticket(String orderNumid,String Trainid,String seatid, String startid, String destationid,HttpServletResponse response) throws Exception {
		System.out.println("座位id:" + seatid);
		System.out.println("出发id:" + startid);
		System.out.println("到达id:" + destationid);
		System.out.println("车次："+Trainid);
		int finTrainId =Integer.parseInt(Trainid);
		int finStartId =Integer.parseInt(startid);
		int finDestation = Integer.parseInt(destationid);
		boolean result2 = refundTicketService.changeMyStatus(seatid,finStartId,finDestation,finTrainId);
		if(result2){
			boolean result = refundTicketService.refundTicket(orderNumid);
			if (result) {
				System.out.println("123");			
			}else {
				System.out.println("1asdfghjk");
			}		
		}else {
			System.out.println("123456789");
		}
		return seatid;
	}
}
