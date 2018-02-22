package com.group3.vo;

import java.util.List;

public class TicketVO {

	private Integer ticketTypeId;
	private String ticketType;
	private Float price;
	private Integer quantity;
	
	@Deprecated
	private List<SeatVO> seats;

	public Integer getTicketTypeId() {
		return ticketTypeId;
	}

	public void setTicketTypeId(Integer ticketTypeId) {
		this.ticketTypeId = ticketTypeId;
	}

	public String getTicketType() {
		return ticketType;
	}

	public void setTicketType(String ticketType) {
		this.ticketType = ticketType;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	public List<SeatVO> getSeats() {
		return seats;
	}

	public void setSeats(List<SeatVO> seats) {
		this.seats = seats;
	}

	@Override
	public String toString() {
		return "TicketVO [ticketTypeId=" + ticketTypeId + ", ticketType=" + ticketType + ", price=" + price
				+ ", quantity=" + quantity + ", seats=" + seats + "]";
	}
	
}
