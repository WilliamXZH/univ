package pers.william.decorator.reference;

public class Telphone extends Decorator{
	
	Telphone(Component cp){
		super(cp);
	}
	
	public void draw() {
		drawTelphone();
		cp.draw();
	}
	
	public void drawTelphone(){
		System.out.println("14天购物保证。货真价实");
		System.out.println("东大超市电话83688888");
	}
}
