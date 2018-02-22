package pers.william.decorator.reference;

public class Goods implements Component{
	
	public void draw() {
		drawGoods();
	}
	
	public void drawGoods(){
		System.out.println("����330ml     2.5");
		System.out.println("��� 230g      4");
		System.out.println();
		System.out.println("�ϼ�(�����)    6.5");
	}
}
