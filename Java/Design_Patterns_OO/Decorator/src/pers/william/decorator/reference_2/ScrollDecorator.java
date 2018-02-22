package pers.william.decorator.reference_2;

public class ScrollDecorator extends Decorator {

	public ScrollDecorator(VisualComponent component) {
		super(component);
		// TODO Auto-generated constructor stub
	}

	public ScrollDecorator() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void draw() {
		// TODO Auto-generated method stub
		component.draw();
		scrollTo();
		
	}
	public void scrollTo(){
		
	}


}
