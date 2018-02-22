package com.group3.po;

@Deprecated
public class Price {

	private Integer trainId;
	private Integer deptureId;
	private Integer destinationId;
	private Float price;
	private Integer distance;

	public Price() {
		super();
	}

	public Price(Integer trainId, Integer deptureId, Integer destinationId, Float price, Integer distance) {
		super();
		this.trainId = trainId;
		this.deptureId = deptureId;
		this.destinationId = destinationId;
		this.price = price;
		this.distance = distance;
	}

	public Integer getTrainId() {
		return trainId;
	}

	public void setTrainId(Integer trainId) {
		this.trainId = trainId;
	}

	public Integer getDeptureId() {
		return deptureId;
	}

	public void setDeptureId(Integer deptureId) {
		this.deptureId = deptureId;
	}

	public Integer getDestinationId() {
		return destinationId;
	}

	public void setDestinationId(Integer destinationId) {
		this.destinationId = destinationId;
	}

	public Float getPrice() {
		return price;
	}

	public void setPrice(Float price) {
		this.price = price;
	}

	public Integer getDistance() {
		return distance;
	}

	public void setDistance(Integer distance) {
		this.distance = distance;
	}

	@Override
	public String toString() {
		return "Price [trainId=" + trainId + ", deptureId=" + deptureId + ", destinationId=" + destinationId
				+ ", price=" + price + ", distance=" + distance + "]";
	}
}
