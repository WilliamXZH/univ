package ppt.fmp.variation_4;

public class ConcreteProduct {

	private ConcreteProduct product = null;
	public ConcreteProduct getInstance(){
		
		if(product == null){
			product = new ConcreteProduct();
		}
		
		return product;
		
	}
	
}
