package com.group3.po;

public class Carriage {

	private Integer id;
	private Integer trainId;
	private Integer serialNum;
	private Integer ticketTypeId;

	public Carriage() {
		super();
	}

	public Carriage(Integer id, Integer trainId, Integer serialNum, Integer ticketTypeId) {
		super();
		this.id = id;
		this.trainId = trainId;
		this.serialNum = serialNum;
		this.ticketTypeId = ticketTypeId;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTrainId() {
		return trainId;
	}

	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}

	public Integer getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(Integer serialNum) {
		this.serialNum = serialNum;
	}

	public Integer getTicketTypeId() {
		return ticketTypeId;
	}

	public void setTicketTypeId(Integer ticketTypeId) {
		this.ticketTypeId = ticketTypeId;
	}

	@Override
	public String toString() {
		return "Carriage [id=" + id + ", trainId=" + trainId + ", serialNum=" + serialNum + ", ticketTypeId="
				+ ticketTypeId + "]";
	}

}
