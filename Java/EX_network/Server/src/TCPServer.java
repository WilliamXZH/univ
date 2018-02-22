import java.io.IOException;
import java.io.DataInputStream;
import java.net.ServerSocket;
import java.net.Socket;
public class TCPServer
{
	public static void main(String[] args) throws IOException{
		ServerSocket ss=new ServerSocket(3336);
		while(true){
			Socket s=ss.accept();
			DataInputStream dis=new DataInputStream(s.getInputStream());
			System.out.println(dis.readUTF());
			System.out.println("Hello,client:"+s.getInetAddress()+":"+s.getPort());
			dis.close();
			s.close();
		}
	}
}