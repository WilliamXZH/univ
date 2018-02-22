package hello;
import java.util.*; 
public class _3 { 
	public static void main(String[] args) {
		String data = "Mini Discs 74 Minute (10-Pack)_5_9.00"; 
		StringTokenizer tknzr = new StringTokenizer(data, "_"); 
		
		String name = tknzr.nextToken();
		int quantity = Integer.parseInt(tknzr.nextToken()); 
		double price = Double.parseDouble(tknzr.nextToken()); 				
		System.out.println( "Name: " + name); 
		System.out.println( "Quantity: " + quantity); 
		System.out.println( "Price: " + price); 
		System.out.println( "Total: " + quantity * price);
	} 
} 
