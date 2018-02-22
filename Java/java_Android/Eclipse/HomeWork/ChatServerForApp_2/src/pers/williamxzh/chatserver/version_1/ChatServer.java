package pers.williamxzh.chatserver.version_1;

import java.io.IOException;
import java.net.BindException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

public class ChatServer {
	private static int port=12345;
	private static List<Client> clients=new ArrayList<Client>();
	
	public static void main(String[] args){
		ServerSocket server;
		try{
			server=new ServerSocket(port);
			while(true){
				Client client =new Client(clients);
				try{
					Socket s=server.accept();
					client.setSocket(s);
					client.start();
					
					clients.add(client);
				}catch(SocketException e){
					System.out.println(client.getName()+" is disconnect.");
				}
			}
		}catch(BindException e){
			port+=10;
			e.printStackTrace();
		}catch(IOException e){
			e.printStackTrace();
		}
	}
}
