package com.group3.mapper;

import com.group3.po.Order;
import com.group3.vo.OrderVO;

public interface RefundMapper {
	public int removeBookByBookNum(String booknum);
	public int changeMyStatus(String seatNum,int startid,int destationid,int Trainid);
	public OrderVO  showMyOrder(String booknum);
}
