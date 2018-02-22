package pers.william.decorator.secondexper;

public class TitleDecorator extends Decorator {

	TitleDecorator(Component component) {
		super(component);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void draw() {
		// TODO Auto-generated method stub
		System.out.println("__________________________________________________");
		System.out.println();
		component.draw();
		System.out.println("__________________________________________________");
		System.out.println();

	}

}
