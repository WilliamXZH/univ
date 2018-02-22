package HTTP;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.ServerSocket;
import java.net.Socket;

public class HTTPServer {
	@SuppressWarnings("null")
	public static void main(String []args){
			
		ServerSocket ss=null;
		try{
			ss=new ServerSocket(8888);
			
		}catch(IOException e){
			e.printStackTrace();
		};
		while(true){
			try{
				Socket s=ss.accept();
				TaskThread t=new TaskThread(s);
				t.start();
				BufferedReader reader=new BufferedReader(new InputStreamReader(s.getInputStream()));
				String firstLineOfRequest;
				firstLineOfRequest=reader.readLine();
				String uri=firstLineOfRequest.split(" ")[1];
				PrintStream writer=new PrintStream(s.getOutputStream());
				writer.println("HTTP/1.1 200 OK");
				if(uri.endsWith(".html")){
					writer.println("Content-Type:text/html");
				}else if(uri.endsWith(".jpg")){
					writer.println("Content-Type:image/jpeg");
				}else{
					writer.println("Content-Type:application/octet-stream");
				}
				FileInputStream in=new FileInputStream("c:/workspace"+uri);
				writer.println("Content-Length"+in.available());
				writer.println();
				writer.flush();
				byte[] b=new byte[2014];
				int len=0;
				len=in.read(b);
				while(len!=1){
					PrintStream os = null;
					os.write(b,0,len);
					len=in.read(b);
				}
				
			}catch(IOException e1){
				e1.printStackTrace();
			}
		}
		
	}
	
}
class TaskThread{
	public TaskThread(Socket s) {
		// TODO Auto-generated constructor stub
	}
	public void start(){
		
	}
}