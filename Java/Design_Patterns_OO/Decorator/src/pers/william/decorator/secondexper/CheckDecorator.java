package pers.william.decorator.secondexper;

public class CheckDecorator extends Decorator {

	CheckDecorator(Component component) {
		super(component);
	}

	@Override
	public void draw() {
		
		System.out.println();
		component.draw();
		System.out.println();
		System.out.println("合计（港币）\t\t\t\t\t1115.40");
		System.out.println("现金\t\t\t\t\t1125.50");
		System.out.println("找赎\t\t\t\t\t10.10");
		System.out.println("交易印花=22");
		System.out.println("额外印花=18");
		System.out.println("----------------------------------------");
		
	}

}
