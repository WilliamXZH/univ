package pers.william.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.net.Socket;
import java.util.Scanner;

public class ClientTest {
	
	public static void main(String[] args){
		Scanner scan=new Scanner(System.in);
		
		Socket s=SocketOper.getSocket();
		System.out.println("connect to server:"+s.toString());
		PrintStream writer=SocketOper.getWriter();
		BufferedReader reader=SocketOper.getReader();
		while(true){

			String com=scan.next();
			writer.println(com);
			
			try {
				System.out.println(reader.readLine());
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		//scan.close();
	}
}
