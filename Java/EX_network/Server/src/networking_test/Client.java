package networking_test;

import java.net.Socket;
import java.net.UnknownHostException;
import java.io.OutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
public class Client
{
	static String ServerHostAddress="127.0.0.1";//������������ַ
	public static void main(String[] args) throws UnknownHostException,IOException{
		String name="abc";//�˺���
		String password="abc";//����
		Client newClient=new Client();
		newClient.Test("ab", password);//�˺ź����������������
		newClient.Test(name, "abcd");
		newClient.Test(name, password);
	}
	public void Test(String name,String password){
		Socket s;
		try {
			s = new Socket(ServerHostAddress,3336);//���������������
			DataOutputStream dos=new DataOutputStream(s.getOutputStream());
			DataInputStream dis=new DataInputStream(s.getInputStream());
			dos.writeUTF(name+"_"+password);//�����˺ź�����
			System.out.println("receive from server:"+dis.readUTF());//��ӡ��¼��Ϣ
			dos.flush();
			dos.close();
	
			s.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}