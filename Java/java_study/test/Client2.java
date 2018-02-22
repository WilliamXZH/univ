import java.net.Socket;
import java.util.Scanner;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.OutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;

public class Client2
{
	public static void main(String []args){
		Client2 client=new Client2();
		client.startConn();
	}
	public void startConn(){
		try{
			Socket s=new Socket("127.0.0.1",12345);
			Scanner scan=new Scanner(System.in);
			//BufferedWriter writer=new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));
			OutputStream writer=s.getOutputStream();
			BufferedReader reader=new BufferedReader(new InputStreamReader(s.getInputStream(),"utf-8"));
			while(true){				
				String com=scan.next();
				writer.write(com.getBytes("utf-8"));
				String rec=reader.readLine();
				System.out.println(rec);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}