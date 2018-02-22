package ppt.fmp.version_2;

import ppt.fmp.version_1.*;

public class ConcreteFactory implements Factory {

	@Override
	public Product createProductA() {
		return new ProductA();
	}

	@Override
	public Product createProductB() {
		return new ProductB();
	}

	@Override
	public Product createProduct() {
		return new DefaultProduct();
	}

}
