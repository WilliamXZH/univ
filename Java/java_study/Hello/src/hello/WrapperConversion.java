package hello;
public class WrapperConversion { 
	public static void main(String[] args) { 
		Integer objectValue = new Integer(100);
		int intValue = objectValue.intValue(); 
		long longValue = objectValue.longValue(); 
		double doubleValue = objectValue.doubleValue();
		String stringValue = objectValue.toString(); 
		System.out.println( "objectValue: " + objectValue); 	
		System.out.println( "intValue: " + intValue); 
		System.out.println( "longValue: " + longValue); 
		System.out.println( "doubleValue: " + doubleValue); 
		System.out.println( "stringValue: " + stringValue); 
	} 
} 
