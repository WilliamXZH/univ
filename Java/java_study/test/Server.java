import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.io.BufferedReader;
import java.io.PrintStream;
import java.io.OutputStream;
import java.io.InputStreamReader;
import java.util.Scanner;
import java.nio.charset.Charset;

public class Server
{
	private	static ServerSocket ss;
	public static void main(String[] args){
		try{
			ss=new ServerSocket(12345);

			while(true){
				try{
					Socket s=ss.accept();
					System.out.println("Connect info:"+s.toString());
					new TaskThread(s).start();
					
				}catch(IOException e){
					e.printStackTrace();
				}
			}
		}catch(IOException e){
			e.printStackTrace();
		}
	
	}
}
class TaskThread extends Thread
{
	Socket s;
	TaskThread(Socket soc){
		this.s=soc;
	}

	public void run(){
		Scanner scan=new Scanner(System.in);
		try{
			BufferedReader reader=new BufferedReader(
				new InputStreamReader(s.getInputStream(),Charset.forName("utf-8")));
			PrintStream writer=new PrintStream(s.getOutputStream());
			while(true){
				String str=reader.readLine();
				System.out.println("receive from client:"+str);

				String str2=scan.next();
				writer.println(str2);
				writer.flush();
			}
		}catch(IOException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}

	}
}