package pers.william.model;

public class Item {

	private Integer itemid;
	private Double rating;

	public Item() {
		super();
	}

	public Item(Integer item, Double rating) {
		super();
		this.itemid = item;
		this.rating = rating;
	}

	public Integer getItem() {
		return itemid;
	}

	public void setItem(Integer item) {
		this.itemid = item;
	}

	public Double getRating() {
		return rating;
	}

	public void setRating(Double rating) {
		this.rating = rating;
	}
	
	public String toString(){
		return itemid + " " + rating;
	}
}
