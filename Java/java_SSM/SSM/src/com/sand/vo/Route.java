package com.sand.vo;

public class Route {
	String start;
	String destion;
	int value;
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getDestion() {
		return destion;
	}
	public void setDestion(String destion) {
		this.destion = destion;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public Route(String start, String destion, int value) {
		super();
		this.start = start;
		this.destion = destion;
		this.value = value;
	}
	@Override
	public String toString() {
		return "Route [start=" + start + ", destion=" + destion + ", value=" + value + "]";
	}
	

}
