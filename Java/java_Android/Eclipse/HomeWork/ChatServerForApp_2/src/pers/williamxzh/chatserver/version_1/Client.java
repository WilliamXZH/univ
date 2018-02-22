package pers.williamxzh.chatserver.version_1;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.Socket;
import java.util.List;

public class Client extends Thread{
	private String ClientName;
	private Socket s;
	private BufferedReader reader;

	private List<Client> clients;
	
	Client(List<Client> clients2){		
		ClientName="";
		this.clients=clients2;
        try {
            reader = new BufferedReader(new InputStreamReader(s.getInputStream(), "utf-8"));
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
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
	
	public boolean isClient(String name){
		return name==this.ClientName;
	}
	
	
	public void run(){
        try {
            String sentence = null;
            while ((sentence = reader.readLine()) != null) {
            	String info[]=sentence.split("_");
            	String to=info[0];
            	String message="";
            	for(int i=1;i<info.length;i++){
            		message+=info[i];
            	}
            	
                for (Client client : clients) {
                	if(client.isClient(to)){		            		
		                try {
		                    client.getSocket().getOutputStream().write(
		                        (this.ClientName+"_"+message + "\n").getBytes("utf-8"));
		                } catch (IOException e) {
		                    e.printStackTrace();
		                }
                	}
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
}
