package ppt.fmp.version_1;

public class ConcreteFactory implements Factory {

	@Override
	public Product createProduct(String type) {
		if(type.equals("A")){
			return new ProductA();
		}else if(type.equals("B")){
			return new ProductB();
		}else{
			return new DefaultProduct();
		}
	}

}
