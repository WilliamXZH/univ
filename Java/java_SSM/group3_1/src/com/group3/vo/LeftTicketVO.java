package com.group3.vo;

import java.util.List;

import com.group3.po.LeftTicket;

@Deprecated
public class LeftTicketVO {

	private Integer trainId;
	private Integer Ticketid;
	private String type;

	private Integer count;

	/*
	 * private Integer trainId; 
	 * private Integer depatureId; 
	 * private Integer destinationId; 
	 * private Integer quantity;
	 */

	List<LeftTicket> lts;

}
