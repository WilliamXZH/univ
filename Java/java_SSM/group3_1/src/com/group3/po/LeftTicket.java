package com.group3.po;

@Deprecated
public class LeftTicket {

	private Integer trainId;
	private Integer depatureId;
	private Integer destinationId;
	private Integer quantity;

	public LeftTicket() {
		super();
	}

	public LeftTicket(Integer trainId, Integer depatureId, Integer destinationId, Integer quantity) {
		super();
		this.trainId = trainId;
		this.depatureId = depatureId;
		this.destinationId = destinationId;
		this.quantity = quantity;
	}

	public Integer getTrainId() {
		return trainId;
	}

	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}

	public Integer getDepatureId() {
		return depatureId;
	}

	public void setDepatureId(Integer depatureId) {
		this.depatureId = depatureId;
	}

	public Integer getDestinationId() {
		return destinationId;
	}

	public void setDestinationId(Integer destinationId) {
		this.destinationId = destinationId;
	}

	public Integer getQuantity() {
		return quantity;
	}

	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

	@Override
	public String toString() {
		return "LeftTicket [trainId=" + trainId + ", depatureId=" + depatureId + ", destinationId=" + destinationId
				+ ", quantity=" + quantity + "]";
	}
}
