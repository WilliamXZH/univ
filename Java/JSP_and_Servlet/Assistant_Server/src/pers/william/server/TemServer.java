package pers.william.server;

import java.io.IOException;
import java.net.BindException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;

public class TemServer {
	
	private int port = 12345;
    public static void main(String[] args){
    	System.out.println("Start server!");
        new TemServer().startServer();
    }

	private void startServer() {
    	ServerSocket server;
		try{
			server=new ServerSocket(port);
			while(true){
				Socket s = null;
				try{
					s=server.accept();
					ClientThread client=new ClientThread(s);
					System.out.println("Connect info:"+s.toString());
					client.start();
				}catch(SocketException e){
					//s.close();
					e.printStackTrace();
				}
			}
		}catch(BindException e){
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
    }

   

}
