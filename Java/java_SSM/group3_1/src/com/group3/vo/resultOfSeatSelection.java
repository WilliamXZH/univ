package com.group3.vo;

public class resultOfSeatSelection {
	String name;
	String idtfType;
	String identify;
	String userType;
	String ticketType;
	String carriageId;
	String seatId;
	String cost;
	public resultOfSeatSelection(){
		
	}
	
	public resultOfSeatSelection(String name, String idtfType, String identify, String userType, String ticketType,
			String carriageId, String seatId, String cost) {
		super();
		this.name = name;
		this.idtfType = idtfType;
		this.identify = identify;
		this.userType = userType;
		this.ticketType = ticketType;
		this.carriageId = carriageId;
		this.seatId = seatId;
		this.cost = cost;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getIdtfType() {
		return idtfType;
	}
	public void setIdtfType(String idtfType) {
		this.idtfType = idtfType;
	}
	public String getIdentify() {
		return identify;
	}
	public void setIdentify(String identify) {
		this.identify = identify;
	}
	public String getUserType() {
		return userType;
	}
	public void setUserType(String userType) {
		this.userType = userType;
	}
	public String getTicketType() {
		return ticketType;
	}
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	public String getCarriageId() {
		return carriageId;
	}
	public void setCarriageId(String carriageId) {
		this.carriageId = carriageId;
	}
	public String getSeatId() {
		return seatId;
	}
	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}
	public String getCost() {
		return cost;
	}
	public void setCost(String cost) {
		this.cost = cost;
	}
	@Override
	public String toString() {
		return "resultOfSeatSelection [name=" + name + ", idtfType=" + idtfType + ", identify=" + identify
				+ ", userType=" + userType + ", ticketType=" + ticketType + ", carriageId=" + carriageId + ", seatId="
				+ seatId + ", cost=" + cost + "]";
	}
	
}
