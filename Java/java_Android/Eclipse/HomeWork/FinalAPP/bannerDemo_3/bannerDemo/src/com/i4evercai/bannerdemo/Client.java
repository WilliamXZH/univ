package com.i4evercai.bannerdemo;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.net.UnknownHostException;

public class Client {
	private static int port=12345;
	private static String address="192.168.168.100";
	
	private static Socket soc=null;
	private static PrintStream writer=null;
	private static BufferedReader reader=null;
	
	public static Socket getSocket(){
		if(soc==null){
			synchronized(Client.class){
				if(soc==null){
					try {
						soc=new Socket(address,port);
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
		return soc;		
	}
	public static PrintStream getWriter(){
		if(writer==null){
			synchronized(Client.class){
				if(writer==null){
					try {
						writer=new PrintStream(getSocket().getOutputStream());
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}					
				}
			}
		}
		return writer;
	}
	public static BufferedReader getReader(){
		if(reader==null){
			synchronized(Client.class){
				if(reader==null){
					try {
						reader=new BufferedReader(new InputStreamReader(getSocket().getInputStream(), "utf-8"));
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
		}
		return reader;
	}
}
