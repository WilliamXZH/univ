package networking_test;

import java.io.IOException;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.net.ServerSocket;
import java.net.Socket;
public class Server
{
	public static void main(String[] args) throws IOException{
		ServerSocket ss=new ServerSocket(3336);
		while(true){
			Socket s=ss.accept();
			DataInputStream dis=new DataInputStream(s.getInputStream());
			DataOutputStream dos=new DataOutputStream(s.getOutputStream());
			String read=dis.readUTF();
			System.out.println("receive from "+s.getInetAddress()+":"+read);//打印客户地址及其发送的信息
			String name=read.split("_")[0];//获取账号
			String password=read.split("_")[1];//获取密码
			if(!name.equals("abc")){
				dos.writeUTF("name's error!");//账号错误
			}else if(!password.equals("abc")){
				dos.writeUTF("password's error!");//密码错误
			}else{
				dos.writeUTF("succeed!");//登陆成功
			}
			dis.close();
			s.close();
		}
	}
}