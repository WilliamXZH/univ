package experiment;
public class OrderItem{
	private int quantity;
	private Product product;
	public OrderItem(Product product2, int quantity2) {
		this.product =product2;
		this.quantity =quantity2;
	}
	public OrderItem() {
	}
	public Product getProduct(){
		return this.product;
	}
	public int getQuantity(){
		return this.quantity;
	}
	public void setQuantity(int quantity){
		this.quantity=quantity;
	}
	public double getValue() {
		return this.product.getPrice() * (double) this.getQuantity();
	}
	public String toString(){
		return this.quantity + " " + this.product.getCode() + " " + this.product.getPrice();
	}
}