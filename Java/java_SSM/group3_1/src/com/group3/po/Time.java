package com.group3.po;


public class Time {

	private Integer trainId;
	private Integer stationId;
	private String arvTime;
	private String lvTime;
	
	public Time() {
		super();
	}

	public Time(Integer trainId, Integer stationId) {
		super();
		this.trainId = trainId;
		this.stationId = stationId;
	}

	public Time(Integer trainId, Integer stationId, String arvTime, String lvTime) {
		super();
		this.trainId = trainId;
		this.stationId = stationId;
		this.arvTime = arvTime;
		this.lvTime = lvTime;
	}

	public Integer getTrainId() {
		return trainId;
	}

	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}

	public Integer getStationId() {
		return stationId;
	}

	public void setStationId(Integer stationId) {
		this.stationId = stationId;
	}

	public String getArvTime() {
		return arvTime;
	}

	public void setArvTime(String arvTime) {
		this.arvTime = arvTime;
	}

	public String getLvTime() {
		return lvTime;
	}

	public void setLvTime(String lvTime) {
		this.lvTime = lvTime;
	}

	@Override
	public String toString() {
		return "Time [trainId=" + trainId + ", stationId=" + stationId + ", arvTime=" + arvTime + ", lvTime=" + lvTime
				+ "]";
	}
}
