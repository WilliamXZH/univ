package server;

import java.net.ServerSocket;
import java.net.Socket;

public class ServiceOne {
	public static void main(String []args){
		final String root_diro="f:/";
		final int port=21;
		try{
			ServerSocket s=new ServerSocket(port);
			System.out.println("����ServerSocket");
			while(true){
				System.out.println("�ȴ��ͻ�������");
				Socket client=s.accept();
				System.out.println("�ͻ���������");
				new ClientThread(client,root_diro).start();
				System.out.println("�ͻ��߳�������");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
