package com.group3.vo;

public class OrderQueryConditionVO {
	String type;
	String way;
	String condition;
	String start;
	String end;
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWay() {
		return way;
	}
	
	public void setWay(String way) {
		this.way = way;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	@Override
	public String toString() {
		return "OrderQueryConditionVO [type=" + type + ", way=" + way + ", condition=" + condition + ", start=" + start
				+ ", end=" + end + "]";
	}
	
}
