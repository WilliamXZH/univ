package ref.dahua.bp.std;

public class ConcreteBuilder2 implements Builder{

	private Product product = new Product();
	
	@Override
	public void builderPartA() {
		// TODO Auto-generated method stub
		product.add("����X");
	}

	@Override
	public void builderPartB() {
		// TODO Auto-generated method stub
		product.add("����Y");;
	}

	@Override
	public Product getResult() {
		// TODO Auto-generated method stub
		return this.product;
	}

}
