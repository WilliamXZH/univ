import java.net.Socket;
import java.net.UnknownHostException;
import java.io.OutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
public class TCPClient
{
	public static void main(String[] args) throws UnknownHostException,IOException{
		while(true){
		Socket s=new Socket("127.0.0.1",3336);
		OutputStream os=s.getOutputStream();
		DataOutputStream dos=new DataOutputStream(os);
		System.out.println("Hello,Server:"+s.getInetAddress()+":"+s.getPort());
		dos.writeUTF("Hello Server!");
		dos.flush();
		dos.close();
		s.close();
		try{Thread.sleep(1000);}catch(Exception e){}
		}
	}
}