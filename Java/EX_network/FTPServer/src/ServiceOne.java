import java.net.ServerSocket;
import java.net.Socket;

public class ServiceOne {
	public static void main(String []args){
		final String root_diro="d:/";
		final int port=21;
		try{
			ServerSocket s=new ServerSocket(port);
			System.out.println("启动ServerSocket");
			while(true){
				System.out.println("等待客户端连接");
				Socket client=s.accept();
				System.out.println("客户端已连接");
				new ClientThread(client,root_diro).start();
				System.out.println("客户线程已启动");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
