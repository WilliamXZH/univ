package pers.william.test;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.net.UnknownHostException;

import org.junit.Test;

public class Test1 {

	private String host = "127.0.0.1";
	private Integer port = 9999;

	@Test
	public void test() throws IOException {
		
		for(int i=0;i<5;i++){
			Socket socket = getConnection(host, port);
			if(socket==null)continue;
			
			for(int j=0;j<=i;j++){
				sendMesaage(socket, "("+i+","+j+")");
				getMessage(socket);
			}

			sendMesaage(socket, "end");
			
			socket.close();
		}
		
	}
	
	public void getMessage(Socket socket){
		BufferedReader reader;
		try {
			reader = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			System.out.println(reader.readLine());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void sendMesaage(Socket socket, String msg) {

		PrintStream writer = null;
		try {
			writer = new PrintStream(socket.getOutputStream());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return;
		}
		writer.println("GET " + msg + " HTTP /1.1");
		writer.flush();
		//writer.close();
	}

	public Socket getConnection(String host, Integer port) {
		try {
			return new Socket(host, port);
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
}
