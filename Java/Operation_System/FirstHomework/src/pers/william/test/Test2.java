package pers.william.test;

import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import pers.william.po.RequestThread;

@Deprecated
public class Test2 {
	private static Integer TOTAL = 10;

	private String host = "127.0.0.1";
	private Integer port = 9999;

	@org.junit.Test
	public void Test(){
		for(int i=0;i<TOTAL;i++){
			try {
				Socket socket = new Socket(host, port);
				new RequestThread(socket).start();
			} catch (UnknownHostException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
}
