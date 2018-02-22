package com.group3.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import com.group3.po.Order;
import com.group3.po.Partner;
import com.group3.po.SeatInfo;
import com.group3.po.SeatQueryCondition;
import com.group3.service.OrderService;
import com.group3.service.PartnerService;
import com.group3.service.SeatService;
import com.group3.vo.TicketVO;
import com.group3.vo.TrainVO;
import com.group3.vo.resultOfSeatSelection;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;



@Controller
public class TicketPurchaseController {
	
	@Resource
	PartnerService partnerService;
	@Resource
	SeatService seatService;
	@Resource
	OrderService orderService;
	@SuppressWarnings("unchecked")
	@RequestMapping("/purchase/ticketPurchase")
	public ModelAndView ticketPurchase(String info,HttpSession session){
		ModelAndView modelAndView = new ModelAndView();
		System.out.println("ticketPurchase!");
		System.out.println(info);
		
		TrainVO tripTrain = null;
		TrainVO backTrain = null;
		TicketVO tripTicket = null;
		TicketVO backTicket = null;
		String []tab = info.split("#");
		if(tab.length==0){
			return modelAndView;
		}else if(tab.length==2){
			List<TrainVO> backs = (List<TrainVO>) session.getAttribute("backTrains");
			Integer backTrainId = Integer.parseInt(tab[1].split(":")[0]);
			Integer backTicketId = Integer.parseInt(tab[1].split(":")[1]);
			
			for (TrainVO trainVO : backs) {
				if(trainVO.getId()==backTrainId){
					backTrain = trainVO;
					//session.setAttribute("backTrain", backTrain);
					JSONObject backtrainJsonObject = JSONObject.fromObject(backTrain);
					modelAndView.addObject("backTrain", backtrainJsonObject);
					break;
				}
			}
			//session.removeAttribute("backTrains");
			System.out.println(backTrain);
			
			
			List<TicketVO> backTicketVOs = tripTrain.getTickets();
			for (TicketVO ticketVO : backTicketVOs) {
				if(ticketVO.getTicketTypeId()==backTicketId){
					backTicket = ticketVO;
					//session.setAttribute("backTicket", backTicket);
					JSONObject backticketJsonobject = JSONObject.fromObject(backTicket);
					modelAndView.addObject("backTicket", backticketJsonobject);
					break;
				}
			}
			System.out.println(backTicket);
		}else{
			modelAndView.addObject("backTrain", "{}");
			modelAndView.addObject("backTicket", "{}");
		}
		
		List<TrainVO> trips = (List<TrainVO>) session.getAttribute("tripTrains");
		System.out.println(tab[0]);
		System.out.println(tab[0].split(":")[0]);
		Integer tripTrainId = Integer.parseInt(tab[0].split(":")[0]);
		Integer tripTicketId = Integer.parseInt(tab[0].split(":")[1]);
		
		for (TrainVO trainVO : trips) {
			if(trainVO.getId()==tripTrainId){
				tripTrain = trainVO;
				//session.setAttribute("tripTrain", tripTrain);
				JSONObject triptrainJsonobject = JSONObject.fromObject(tripTrain);
				modelAndView.addObject("tripTrain", triptrainJsonobject);
				break;
			}
		}
		System.out.println(tripTrain);
		
		
		List<TicketVO> tripTicketVOs = tripTrain.getTickets();
		for (TicketVO ticketVO : tripTicketVOs) {
			if(ticketVO.getTicketTypeId()==tripTicketId){
				tripTicket = ticketVO;
				//session.setAttribute("tripTicket", tripTicket);
				JSONObject tripticketJsonobeject = JSONObject.fromObject(tripTicket);
				modelAndView.addObject("tripTicket", tripticketJsonobeject);
				break;
			}
		}
		//session.removeAttribute("tripTrains");
		System.out.println(tripTicket);
		
		String mainUserId = (String)session.getAttribute("id");
		List<Partner> partners = partnerService.getPartnerInfo(mainUserId);
		
		if(partners.isEmpty()){
			modelAndView.addObject("partners", "[]");
		}else{
			JSONArray partnersJsonarray = JSONArray.fromObject(partners);
			
			modelAndView.addObject("partners",partnersJsonarray);
			//session.setAttribute("partners", jsonArray);
			System.out.println(partnersJsonarray);
		}
		
		modelAndView.setViewName("/purchase/ticketPurchase");
		modelAndView.addObject("info", info);
		
		return modelAndView;
	}
	
	
	@RequestMapping("/purchase/addOrder")
	public void addOrder(HttpServletRequest request,HttpServletResponse response,HttpSession session) throws IOException, ParseException{
		String orderInfo = request.getParameter("oi"); 
		JSONObject trainInfo = JSONObject.fromObject(request.getParameter("ti"));
        System.out.println("orderInfo:"+orderInfo);
        System.out.println("trainInfo:"+trainInfo);
        /* 在这一步中，需要通过json获取
         * memberName,departureId,destinationId,trainId,departTime
         * idftType,identify,userType,ticketType,cost
         * userId通过session获取
         * time在写入数据库时获取当前时间
         * */
        JSONArray orderList = JSONArray.fromObject(orderInfo);
        Iterator<Object> it = orderList.iterator();
        int listSize = orderList.size();
        System.out.println("orderList[0]:"+orderList.get(0));
        /**
         * allocSeat
         * parameter
         * trainId,ticketTypeId,depatureId,destinationId,orderSize
         */
        List<SeatInfo> seatList = seatService.allocSeat(new SeatQueryCondition((Integer)trainInfo.get("trainId"),(Integer)trainInfo.get("ticketTypeId"),
        		(String)trainInfo.getString("departureId"),(String)trainInfo.getString("destinationId"),listSize));
        for (SeatInfo seat : seatList) {
			System.out.println("seatInfo:"+seat);
		}
        JSONObject orderItem;
        List<resultOfSeatSelection> resultList = new ArrayList<resultOfSeatSelection>();
        int seatIndex=0;
        while(it.hasNext()){
        	System.out.println(seatIndex);
        	orderItem = (JSONObject) it.next();
        	System.out.println("orderItem:"+orderItem);
        	Order newOrder = new Order();
        	SimpleDateFormat sdf =   new SimpleDateFormat("yyyy-MM-dd");
        	newOrder.setUserId((String)session.getAttribute("id"));
        	newOrder.setMemberName(orderItem.get("name").toString());
        	newOrder.setSeatId(seatList.get(seatIndex).getId());
        	newOrder.setDepatureId((Integer)orderItem.get("departureId"));
        	newOrder.setDestinationId((Integer)orderItem.get("destinationId"));
        	newOrder.setTrainId((Integer)orderItem.get("trainId"));
        	//newOrder.setDepartTime(new Date(sdf.parse(orderItem.get("departTime").toString()).getTime()));
        	newOrder.setDepartTime(orderItem.get("departTime").toString());
        	newOrder.setSeatIds(seatList.get(seatIndex).getIds());
        	//其余五个属性 一个是id，触发器自动生成；四个是跟支付有关的，下一个页面再进行设置。
        	System.out.println(newOrder);
        	//增加订单
        	orderService.addOrder(newOrder);
        	//初始化resultList...
            resultList.add(new resultOfSeatSelection(newOrder.getMemberName(),
            		orderItem.get("idtfType").toString(),orderItem.get("identify").toString(),
            		orderItem.get("userType").toString(),orderItem.get("ticketType").toString(),
            		seatList.get(seatIndex).getCarriageSerialNum().toString(),seatList.get(seatIndex).getNum(),
            		orderItem.get("cost").toString()));
        	seatIndex++;
        }
        
        JSONArray jsonArray = JSONArray.fromObject(resultList);
        response.setContentType("application/json;charset=UTF-8");
        System.out.println(jsonArray);
        response.getWriter().print(jsonArray);
        
        
	}
	
}
