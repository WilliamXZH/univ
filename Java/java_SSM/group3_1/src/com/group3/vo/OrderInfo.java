package com.group3.vo;

public class OrderInfo {
	Integer payStatus;
	String orderId;
	String userName;
	String trainName;
	String carriage;
	String seat;
	String depature;//
	String destination;
	String ticketType;
	float cost;
	String orderTime;
	String departTime;
	String payMethod;
	public Integer getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(Integer payStatus) {
		this.payStatus = payStatus;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getTrainName() {
		return trainName;
	}
	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}
	public String getCarriage() {
		return carriage;
	}
	public void setCarriage(String carriage) {
		this.carriage = carriage;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public String getDepature() {
		return depature;
	}
	public void setDepature(String depature) {
		this.depature = depature;
	}
	public String getDestination() {
		return destination;
	}
	public void setDestination(String destination) {
		this.destination = destination;
	}
	public String getTicketType() {
		return ticketType;
	}
	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public String getOrderTime() {
		return orderTime;
	}
	public void setOrderTime(String orderTime) {
		this.orderTime = orderTime;
	}
	public String getDepartTime() {
		return departTime;
	}
	public void setDepartTime(String departTime) {
		this.departTime = departTime;
	}
	public String getPayMethod() {
		return payMethod;
	}
	public void setPayMethod(String payMethod) {
		this.payMethod = payMethod;
	}
	@Override
	public String toString() {
		return "OrderInfo [payStatus=" + payStatus + ", orderId=" + orderId + ", userName=" + userName + ", trainName="
				+ trainName + ", carriage=" + carriage + ", seat=" + seat + ", depature=" + depature + ", destination="
				+ destination + ", ticketType=" + ticketType + ", cost=" + cost + ", orderTime=" + orderTime
				+ ", departTime=" + departTime + ", payMethod=" + payMethod + "]";
	}
	
}
