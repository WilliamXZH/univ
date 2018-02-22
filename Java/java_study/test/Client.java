import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.SocketException;
import java.net.BindException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.util.Scanner;

public class Client
{	
	private static Socket s;
	public static void main(String []args){
		try{
			s=new Socket("127.0.0.1",12345);
			
			System.out.println("Connect info:"+s.toString());
			Scanner scan=new Scanner(System.in);
			PrintStream writer=new PrintStream(s.getOutputStream());
			InputStream in=s.getInputStream();
			BufferedReader reader=new BufferedReader(new InputStreamReader(in));
			while(true){
				
				writer.println(scan.next());
				writer.flush();

				System.out.println(reader.readLine());
			}

		}catch(SocketException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}


