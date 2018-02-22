package ppt.fmp.variation_3;

public class ConcreteProduct implements Product {

	@Override
	public Product getProduct() {
		return new ConcreteProduct();
	}

}
