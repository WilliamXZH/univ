package pers.william.chat.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.BindException;
import java.net.ServerSocket;
import java.net.Socket;
import java.net.SocketException;
import java.util.List;
import java.util.ArrayList;

public class ChatServer {
	
	private int port = 12345;
    public List<Client> clients = new ArrayList<Client>();

    public static void main(String[] args) throws IOException {
        new ChatServer().startServer();
    }

    private void startServer() {
    	ServerSocket server;	
		try{
			server=new ServerSocket(port);
			while(true){
				Client client=new Client();
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

    public class Client extends Thread {
    	String ClientName;
        Socket s;
        BufferedReader reader;
        
        
    	public String getClientName(){
    		return this.ClientName;
    	}
    	public Socket getSocket(){
    		return this.s;
    	}
    	public void setSocket(Socket s){
    		this.s=s;
    	}
    	
    	public void setClientName(String name){
    		this.ClientName=name;
    	}
        
        Client(){ 	
            try {
                reader= new BufferedReader(new InputStreamReader(s.getInputStream(), "utf-8"));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        public void run() {
            try {
                String sentence = null;
                while ((sentence = reader.readLine()) != null) {
                	this.setName(sentence.split(":")[0]);
                    for (Client s : clients) {
                        try {
                            s.getSocket().getOutputStream().write(
                                (sentence + "\n").getBytes("utf-8"));
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
