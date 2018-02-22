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
		System.out.println("�ϼƣ��۱ң�\t\t\t\t\t1115.40");
		System.out.println("�ֽ�\t\t\t\t\t1125.50");
		System.out.println("����\t\t\t\t\t10.10");
		System.out.println("����ӡ��=22");
		System.out.println("����ӡ��=18");
		System.out.println("----------------------------------------");
		
	}

}
