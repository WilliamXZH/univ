package pers.william.decorator.reference;

public class Thread1 extends Decorator {

	
	Thread1(Component cp){
		super(cp);
	}
	
	public void draw() {
		drawThread1();
		cp.draw();
	}
	
	public void drawThread1(){
		System.out.println("---------------------");
	}
}
