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
			System.out.println("receive from "+s.getInetAddress()+":"+read);//��ӡ�ͻ���ַ���䷢�͵���Ϣ
			String name=read.split("_")[0];//��ȡ�˺�
			String password=read.split("_")[1];//��ȡ����
			if(!name.equals("abc")){
				dos.writeUTF("name's error!");//�˺Ŵ���
			}else if(!password.equals("abc")){
				dos.writeUTF("password's error!");//�������
			}else{
				dos.writeUTF("succeed!");//��½�ɹ�
			}
			dis.close();
			s.close();
		}
	}
}