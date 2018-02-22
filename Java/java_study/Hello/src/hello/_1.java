package hello;
import java.io.*; 
public class _1 { 
	private static BufferedReader stdIn = new BufferedReader(new InputStreamReader(System.in)); 
	private static PrintWriter stdOut = new PrintWriter(System.out, true); 
	public static void main(String[] args) throws IOException { 
	stdOut.print("Please enter you name on this line: "); stdOut.flush(); 
	String input = stdIn.readLine(); 
	stdOut.println("Hello " + input); 
	}
} 
