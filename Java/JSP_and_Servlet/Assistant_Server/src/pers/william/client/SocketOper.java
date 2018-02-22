package pers.william.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.io.InputStreamReader;
import java.net.Socket;

public class SocketOper {
	private static int port=12345;
	private static String address="172.17.1.76";
	
	private static Socket s=null;
	private static PrintStream writer=null;
	private static BufferedReader reader=null;
	
	public static Socket getSocket(){
		if(s==null){
			synchronized(SocketOper.class){
				if(s==null){							
					try{
						s=new Socket(address,port);
					}catch(Exception e){
						e.printStackTrace();
					}
				}
			}
		}
		return s;
	}
	public static PrintStream getWriter(){
		if(writer==null){
			try {
				writer=new PrintStream(getSocket().getOutputStream());
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return writer;
	}
	public static BufferedReader getReader(){
		if(reader==null){
			try {
				reader=new BufferedReader(new InputStreamReader(getSocket().getInputStream(),"utf-8"));
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return reader;
	}
}
