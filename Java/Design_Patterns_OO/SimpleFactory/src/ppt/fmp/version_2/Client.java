package ppt.fmp.version_2;

import ppt.fmp.version_1.Product;

public class Client {

	public static void main(String[] args) {
		Factory factory = new ConcreteFactory();
		Product productA = factory.createProductA();
		Product productB = factory.createProductB();
		System.out.println(productA);
		System.out.println(productB);
	}
	
}
