package com.group3.po;

public class SeatQueryCondition {
	private Integer trainId;
	private Integer ticketTypeId;
	private String departure;
	private String destination;
	private Integer seatNum;
	public SeatQueryCondition() {
		super();
	}
	public SeatQueryCondition(Integer trainId, Integer ticketTypeId, String departure, String destination,
			Integer seatNum) {
		super();
		this.trainId = trainId;
		this.ticketTypeId = ticketTypeId;
		this.departure = departure;
		this.destination = destination;
		this.seatNum = seatNum;
	}
	public Integer getTrainId() {
		return trainId;
	}
	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}
	public Integer getTicketTypeId() {
		return ticketTypeId;
	}
	public void setTicketTypeId(Integer ticketTypeId) {
		this.ticketTypeId = ticketTypeId;
	}
	public String getDeparture() {
		return departure;
	}
	public void setDeparture(String departure) {
		this.departure = departure;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public Integer getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(Integer seatNum) {
		this.seatNum = seatNum;
	}
	@Override
	public String toString() {
		return "SeatQueryCondition [trainId=" + trainId + ", ticketTypeId=" + ticketTypeId + ", departure=" + departure
				+ ", destination=" + destination + ", seatNum=" + seatNum + "]";
	}
}
