package pers.william.server;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.UnsupportedEncodingException;
import java.net.Socket;
import java.util.Date;
import java.util.Scanner;

import pers.william.database.NewsOper;
import pers.william.database.ServiceOper;
import pers.william.database.UserOper;
import pers.william.users.NonAdmin;
import pers.william.users.User;

public class ClientThread extends Thread {
    private Socket s;
    private Scanner scan;
    private PrintStream writer;
    private BufferedReader reader;
    
    private User client;
    
    ClientThread(Socket soc){
    	this.s=soc;
    	scan=new Scanner(System.in);
    	
    	client=new NonAdmin();
    	
		try {
			writer=new PrintStream(s.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
		}
		try {
			reader= new BufferedReader(new InputStreamReader(s.getInputStream(), "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

    }
	public void run(){
        try {
            while(true){
            	//System.out.println("Connect info:"+s.toString());
            	String post="";
            	String get=reader.readLine();
            	
            	System.out.println(new Date()+":");
            	System.out.println("Receive from client:"+get);
  
            	
            	String command=get.split("#")[0];
            	
            	if(command.toLowerCase().equals("getnewsbytype")){
            		
            	}else if(command.toLowerCase().equals("getnewsbykeyword")){
            		post=NewsOper.getNews(get.split("#")[1]);
            		
            	}else if(command.toLowerCase().equals("getcommentbyid")){
            		post=NewsOper.getComments(Integer.parseInt(get.split("#")[1]));
            	
            	}else if(command.equals("")){
            		post="error#No parameter";
            	}else if(command.toLowerCase().equals("testname")){
            		post=""+UserOper.testName(get.split("#")[1]);
            		
            	}else if(command.toLowerCase().equals("register")){
            		post=UserOper.register(get.split("#")[1]);
            		
            	}else if(command.toLowerCase().equals("login")){
            		String NAP=get.split("#")[1];
            		client.setName(NAP.split("_")[0]);
            		post=UserOper.login(NAP.split("_")[0],NAP.split("_")[1]);    
            		
            	}else if(command.toLowerCase().equals("logout")){
            		break;
            		
            	}else if(command.toLowerCase().equals("handleitem")){
            		System.out.println(get.split("#")[1]);
            		post=scan.next();
            		
            	}else if(command.toLowerCase().equals("addorderitem")){
            		post=""+ServiceOper.addOrder(get.split("#")[1]);
            		
            	}else if(command.toLowerCase().equals("getorders")){
            		post=ServiceOper.queryOrder(get.split("#")[1].split("_")[0],
            				get.split("#")[1].split("_")[1],get.split("#")[1].split("_")[2]);
            		
            	}else if(command.toLowerCase().equals("getstate")){
            		//post="state#5_4_3_2_1";
            		post=ServiceOper.getState(get.split("#")[1]);
            		
            	}else if(command.toLowerCase().equals("")){
            		
            	}else{         		
            		post="ERROR#Please send a meaning instructions.";
            		continue;
            	}          	
            	writer.println(post);
        		writer.flush();
        		
        		System.out.println("Send to client:"+post);
    		}
            s.close();
		} catch (IOException e) {
			e.printStackTrace();
		}    
    	//scan.close();
    }
}