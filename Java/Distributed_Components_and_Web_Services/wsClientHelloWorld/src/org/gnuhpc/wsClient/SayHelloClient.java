package org.gnuhpc.wsClient;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import javax.xml.ws.BindingProvider;

public class SayHelloClient {

	/**
	 * @param args
	 */
	public static void main(String []args){
		SayHelloService shs = new SayHelloService();
		SayHello sh = (SayHello)shs.getSayHelloPort();
		((BindingProvider)sh).getRequestContext().put(
				BindingProvider.ENDPOINT_ADDRESS_PROPERTY, 
				"http://localhost:8080/wsServerExample");
		System.out.println(((BindingProvider)sh).toString());
		String userName = null;
		boolean exit = false;
		while(!exit){
			System.out.println(
					"\n Pleanse enter your name(type 'quit' to exit):");
			BufferedReader br = new BufferedReader(new InputStreamReader(
					System.in));
			try{
				userName = br.readLine();
			}catch(IOException e){
				System.out.println("Errorreadingname.");
				System.exit(1);
			}
			if(!(exit=userName.trim().equalsIgnoreCase("quit")
					||userName.trim().equalsIgnoreCase("exit"))){
				System.out.println(sh.getGreeting(userName));
			}
		}
		System.out.println("\nThank you for running the client.");
	}
	
}
