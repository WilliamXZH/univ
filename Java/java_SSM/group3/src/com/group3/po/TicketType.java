package com.group3.po;

public class TicketType {

	private Integer id;
	private String type;

	public TicketType() {
		super();
	}

	public TicketType(Integer id, String type) {
		super();
		this.id = id;
		this.type = type;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		return "TicketType [id=" + id + ", type=" + type + "]";
	}
}
