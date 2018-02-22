package shopping.cart;
import java.io.Serializable;

public class Product implements Serializable {
	private String id;// 产品标识
	private String name;// 产品名称
	private String description;// 产品描述
	private double price;// 产品价格

	public Product() {
	}

	public Product(String id, String name, String description, double price) {
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
	}


	public void setId(String id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getId() {
		return id;
	}

	public String getName() {
		return name;
	}

	public String getDescription() {
		return description;
	}

	public double getPrice() {
		return price;
	}
}