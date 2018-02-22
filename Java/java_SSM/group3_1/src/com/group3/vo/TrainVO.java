package com.group3.vo;

import java.util.List;

public class TrainVO {

	private Integer id;
	private String serialNum;
	private String entireRoute;
	private String localRoute;
	private String bdDate;
	private List<StationVO> stations;
	private List<TicketVO> tickets;
	
	private String departure;
	private String destination;

	private String lvTime;
	private String arvTime;
	private String totalTime;
	

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

	public String getTotalTime() {
		return totalTime;
	}

	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}

	public String getLvTime() {
		return lvTime;
	}

	public void setLvTime(String lvTime) {
		this.lvTime = lvTime;
	}

	public String getArvTime() {
		return arvTime;
	}

	public void setArvTime(String arvTime) {
		this.arvTime = arvTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getSerialNum() {
		return serialNum;
	}

	public void setSerialNum(String serialNum) {
		this.serialNum = serialNum;
	}

	public String getEntireRoute() {
		return entireRoute;
	}

	public void setEntireRoute(String entireRoute) {
		this.entireRoute = entireRoute;
	}

	public String getBdDate() {
		return bdDate;
	}

	public void setBdDate(String bdDate) {
		this.bdDate = bdDate;
	}

	public String getLocalRoute() {
		return localRoute;
	}

	public void setLocalRoute(String localRoute) {
		this.localRoute = localRoute;
	}

	public List<StationVO> getStations() {
		return stations;
	}

	public void setStations(List<StationVO> stations) {
		this.stations = stations;
	}

	public List<TicketVO> getTickets() {
		return tickets;
	}

	public void setTickets(List<TicketVO> tickets) {
		this.tickets = tickets;
	}

	@Override
	public String toString() {
		return "TrainVO [id=" + id + ", serialNum=" + serialNum + ", entireRoute=" + entireRoute + ", bdDate=" + bdDate
				+ ", stations=" + stations + ", tickets=" + tickets + "]";
	}

}
