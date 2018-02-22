import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class Server {
	public static void main(String []args) throws Exception{
		ServerSocket ss=null;
		try{
			ss=new ServerSocket(8888);
		}catch(IOException e){
			e.printStackTrace();
		};
		while(true){
			try{
				Socket s=ss.accept();
				//TaskThread t=new TaskThread(s);
				//t.start();		
				new TaskThread(s).start();
			}catch(IOException e){
				e.printStackTrace();
			}
			
		}
	}
}