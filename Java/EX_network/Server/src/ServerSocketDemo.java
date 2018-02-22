import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

public class ServerSocketDemo {
	@SuppressWarnings("resource")
	public static void main(String[] args) throws IOException{
		try{
			ServerSocket serverSocket=null;
			Socket clientSocket=null;
			String str=null;
			DataOutputStream out=null;
			DataInputStream in=null;
			serverSocket=new ServerSocket(3337);
			System.out.println("等待与客户机的连接");
			clientSocket=serverSocket.accept();
			in=new DataInputStream(clientSocket.getInputStream());
			
			out=new DataOutputStream(clientSocket.getOutputStream());
			while(true){
				str=in.readUTF();
				out.writeUTF(str);
				System.out.println("服务器收到:"+str);
				Thread.sleep(1000);
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
