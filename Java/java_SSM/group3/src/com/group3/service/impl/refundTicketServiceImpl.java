package com.group3.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.RefundMapper;
import com.group3.po.Order;
import com.group3.service.RefundTicketService;
import com.group3.vo.OrderInfo;
import com.group3.vo.OrderVO;

@Service
public class refundTicketServiceImpl implements RefundTicketService {
	@Resource
	RefundMapper refundMapper;

	@Override
	public boolean refundTicket(String orderNum) {
		 int result=refundMapper.removeBookByBookNum(orderNum);
		if (result > 0) {
			
			return true;
		}
		return false;
	}

	@Override
	public boolean changeMyStatus(String seatNum,int startid,int destationid,int Trainid) {
		 int result=refundMapper.changeMyStatus(seatNum,startid,destationid,Trainid);
			if (result > 0) {
				return true;
			}
			return false;
	}

	@Override
	public OrderVO showMyOrder(String orderNum) {
		OrderVO result = refundMapper.showMyOrder(orderNum);
		return result;
		
	}


}
