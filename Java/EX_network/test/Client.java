import java.net.Socket;
import java.util.Scanner;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;

public class Client
{
	public static void main(String []args){
		Client client=new Client();
		client.startConn();
	}
	public void startConn(){
		try{
			Socket s=new Socket("118.202.10.172",12345);
			Scanner scan=new Scanner(System.in);
			System.out.println("Connect info:"+s.toString());
			PrintStream writer=new PrintStream(s.getOutputStream());
			BufferedReader reader=new BufferedReader(
				new InputStreamReader(s.getInputStream(),"utf-8"));
			while(true){		
				System.out.println("Input some info:");
				String com=scan.next();
				System.out.println("send:"+com);
				//OutputStream writer=s.getOutputStream();
				//writer.write(com.getBytes("utf-8"));
				writer.println(com);
				//writer.flush();
				String rec=reader.readLine();
				System.out.println("receive:"+rec);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}