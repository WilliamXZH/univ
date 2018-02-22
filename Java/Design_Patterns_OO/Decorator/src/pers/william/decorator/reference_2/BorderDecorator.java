package pers.william.decorator.reference_2;

public class BorderDecorator extends Decorator {

	public BorderDecorator(VisualComponent component) {
		super(component);
		// TODO Auto-generated constructor stub
	}

	public BorderDecorator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void draw() {
		// TODO Auto-generated method stub
		component.draw();
		drawBorder();
		
		
	}
	public void drawBorder(){
		
	}


}
