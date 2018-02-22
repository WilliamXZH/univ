package hello;
import java.io.*; 
public class PrintlnDemo { 
	
	private static PrintWriter stdOut = new PrintWriter(System.out, true); 

	public static void main(String[] args) { 
		stdOut.println( "A line of output.");
		stdOut.println(5);
		stdOut.println(7.27); 
		stdOut.println(true); 
		stdOut.println( );
	} 
}
