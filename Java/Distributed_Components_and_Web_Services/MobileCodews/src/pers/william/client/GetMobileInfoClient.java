package pers.william.client;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.xml.ws.BindingProvider;

import pers.william.jaxws.*;

public class GetMobileInfoClient {
	
	/**
	 * @param args
	 */
	public static void main(String []args){
		MobileCodeWS shs = new MobileCodeWS();
		MobileCodeWSSoap sh = (MobileCodeWSSoap)shs.getMobileCodeWSSoap();
		((BindingProvider)sh).getRequestContext().put(
				BindingProvider.ENDPOINT_ADDRESS_PROPERTY, 
				"http://ws.webxml.com.cn/WebServices/MobileCodeWS.asmx");
		System.out.println(((BindingProvider)sh).toString());
		String mobileCode = null;
		boolean exit = false;
		while(!exit){
			System.out.println(
					"\n Pleanse enter your MobileCode(type 'quit' to exit):");
			BufferedReader br = new BufferedReader(new InputStreamReader(
					System.in));
			try{
				mobileCode = br.readLine();
			}catch(IOException e){
				System.out.println("Errorreadingname.");
				System.exit(1);
			}
			if(!(exit=mobileCode.trim().equalsIgnoreCase("quit")
					||mobileCode.trim().equalsIgnoreCase("exit"))){
				System.out.println(sh.getMobileCodeInfo(mobileCode, ""));
			}
		}
		System.out.println("\nThank you for running the client.");
	}
	
}
