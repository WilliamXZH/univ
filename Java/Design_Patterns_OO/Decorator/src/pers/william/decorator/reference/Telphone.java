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
		System.out.println("14�칺�ﱣ֤�������ʵ");
		System.out.println("�����е绰83688888");
	}
}
