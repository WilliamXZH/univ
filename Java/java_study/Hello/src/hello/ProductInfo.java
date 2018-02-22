package hello;
import java.util.*; 
public class ProductInfo { 
	public static void main(String[] args) {
		String data = "Mini Discs 74 Minute (10-Pack)_5_9.00"; 
		StringTokenizer tknzr = new StringTokenizer(data, "_"); 
		String name = tknzr.nextToken(); 
		String quantity = tknzr.nextToken(); 
		String price = tknzr.nextToken(); 
		System.out.println( "Name: " + name); 
		System.out.println( "Quantity: " + quantity); 
		System.out.println( "Price: " + price); 
	}
 } 
