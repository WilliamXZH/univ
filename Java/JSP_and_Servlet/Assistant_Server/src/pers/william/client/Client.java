package pers.william.client;

import java.net.Socket;
import java.util.Scanner;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.BufferedReader;

public class Client
{
	public static void main(String []args){
		Client client=new Client();
		client.startConn();
	}
	public void startConn(){
		try{
			Socket s=new Socket("118.202.10.172",12345);
			Scanner scan=new Scanner(System.in);
			//BufferedWriter writer=new BufferedWriter(new OutputStreamWriter(s.getOutputStream()));
			OutputStream writer=s.getOutputStream();
			BufferedReader reader=new BufferedReader(new InputStreamReader(s.getInputStream(),"utf-8"));
			while(true){				
				String com=scan.next();
				writer.write(com.getBytes("utf-8"));
				writer.flush();
				
				System.out.println(reader.readLine());
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}