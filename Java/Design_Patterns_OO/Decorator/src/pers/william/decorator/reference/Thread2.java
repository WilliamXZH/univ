package pers.william.decorator.reference;

public class Thread2 extends Decorator {

	Thread2(Component cp){
		super(cp);
	}
	
	public void draw() {
		drawThread2();
		cp.draw();
	}
	
	public void drawThread2(){
		System.out.println("*********************");
	}
}
