package pers.william.decorator.reference;

public class Title extends Decorator {
	
	Title(Component cp){
		super(cp);
	}
	
	public void draw() {
		drawTitle();
		cp.draw();
	}

	public void drawTitle(){
		System.out.println("              东北大学超市                                    ");
	}
}
