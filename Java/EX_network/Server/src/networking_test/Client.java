package networking_test;

import java.net.Socket;
import java.net.UnknownHostException;
import java.io.OutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
public class Client
{
	static String ServerHostAddress="127.0.0.1";//服务器主机地址
	public static void main(String[] args) throws UnknownHostException,IOException{
		String name="abc";//账号名
		String password="abc";//密码
		Client newClient=new Client();
		newClient.Test("ab", password);//账号和密码的三种组合情况
		newClient.Test(name, "abcd");
		newClient.Test(name, password);
	}
	public void Test(String name,String password){
		Socket s;
		try {
			s = new Socket(ServerHostAddress,3336);//与服务器建立连接
			DataOutputStream dos=new DataOutputStream(s.getOutputStream());
			DataInputStream dis=new DataInputStream(s.getInputStream());
			dos.writeUTF(name+"_"+password);//发送账号和密码
			System.out.println("receive from server:"+dis.readUTF());//打印登录信息
			dos.flush();
			dos.close();
	
			s.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}