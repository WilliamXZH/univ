package ref.dahua.bp.std;

public class ConcreteBuilder1 implements Builder{

	private Product product = new Product();
	
	@Override
	public void builderPartA() {
		// TODO Auto-generated method stub
		product.add("����A");
	}

	@Override
	public void builderPartB() {
		// TODO Auto-generated method stub
		product.add("����B");
	}

	@Override
	public Product getResult() {
		// TODO Auto-generated method stub
		return this.product;
	}

	
}
