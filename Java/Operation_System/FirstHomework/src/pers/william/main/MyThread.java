package pers.william.main;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.net.Socket;
import java.util.concurrent.ThreadPoolExecutor;

import pers.william.po.ResponseThread;

public class MyThread implements Runnable {
	
	private Integer mode; 
	private Socket s ;
	private ThreadPoolExecutor threadPoolExecutor;

	public MyThread(Integer mode,Socket s,ThreadPoolExecutor executor) {
		super();
		this.mode = mode;
		this.s = s;
		this.threadPoolExecutor = executor;
	}

	@Override
	public void run() {
		
		//System.out.println(s);
		BufferedReader reader = null;
		PrintStream writer = null;
		try {
			reader = new BufferedReader(new InputStreamReader(s.getInputStream()));
			writer = new PrintStream(s.getOutputStream());
			
			
			while(s!=null&&reader!=null){
				String line = reader.readLine();
				System.out.println(line);
				String file = line.split(" ")[1];
				
				if(file.toLowerCase().equals("end")){
					break;
				}else{
					if(mode== null){
						System.out.println("mode is not defined!");
						break;
					}else if(mode == MainThread.FCFS){
						threadPoolExecutor.execute(new ResponseThread(s,file));
					}else if(mode == MainThread.SFF){
						
					}else{
						System.out.println("some error may occured!");
					}
				}
				
			}

//			writer.println("HTTP/1.1 200 OK");
//			writer.println("Content-Type:text/plain");
//			writer.println("Content-Length:7");
//			writer.println("response to client:"+s+", task:"  + "finished!");
//			writer.println();
//			writer.flush();
			
			try {
				Thread.sleep(3000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
