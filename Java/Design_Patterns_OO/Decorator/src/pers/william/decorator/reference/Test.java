package pers.william.decorator.reference;

public class Test {

	public static void main(String[] args) {
		System.out.println("example1:\n");
		Component example1 = new Title(new Thread1(new Telphone(new Thread2(new Goods()))));
		example1.draw();
		
		System.out.println("\nexample2:\n");
		Component example2 = new Thread1(new Telphone(new Thread1(new Title(new Thread2(new Goods())))));
		example2.draw();
	}

}
