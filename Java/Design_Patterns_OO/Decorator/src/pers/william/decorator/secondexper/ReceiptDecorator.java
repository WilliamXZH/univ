package pers.william.decorator.secondexper;

public class ReceiptDecorator extends Decorator {

	ReceiptDecorator(Component component) {
		super(component);
	}

	@Override
	public void draw() {
		
		component.draw();
		System.out.println("总印花=40");
		System.out.println("\t14天购物保障（凭单据可享退/换保障，");
		System.out.println("\t印花须一并退回，详情请参阅店内海报）");
		System.out.println("\t        新文化中心    电话:23687759");
		System.out.println("18-03-2010 15:59:33 R#01 C:3895 MAY\tT#26142296");
		System.out.println("·◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆··◆·");
		System.out.println("\t索取塑料购物袋须缴付每个港币五号环保缴费，");
		System.out.println("\t\t缴费不设退款");
	}

}
