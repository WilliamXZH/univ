package pers.william.decorator.reference;

public class Goods implements Component{
	
	public void draw() {
		drawGoods();
	}
	
	public void drawGoods(){
		System.out.println("可乐330ml     2.5");
		System.out.println("面包 230g      4");
		System.out.println();
		System.out.println("合计(人民币)    6.5");
	}
}
