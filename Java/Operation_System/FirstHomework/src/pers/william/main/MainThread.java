package pers.william.main;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Scanner;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class MainThread extends Thread {
	
	public static Integer FCFS = 1;
	public static Integer SFF = 2;

	//private static Integer port = 9999;
	
	//private Integer nThread;
	private Integer mode;
	//private String host;
	private ServerSocket serverSocket;
	private ThreadPoolExecutor threadPoolExecutor;
	
	private static String tmplate = "./webserver PORT NTHREADS MODE ";
	
	
	public MainThread(Integer port, Integer mode,Integer nThread,String host ) throws IOException{
		
		this.mode = mode;
		
		serverSocket = new ServerSocket(port);
		threadPoolExecutor = new ThreadPoolExecutor(nThread, 3*nThread, 3, 
				TimeUnit.SECONDS,new ArrayBlockingQueue<Runnable>(10) );
	}
	
	
	/*
	 * Arguments test:
	 * ./localhost 9999 5 fcfs
	 */
	public static void main(String[] args) throws IOException{
		
		//Scanner scanner = new Scanner(System.in);
		//System.out.println(tmplate);
//		host = scanner.next();
//		port = scanner.nextInt();
//		nThread = scanner.nextInt();
//		mode = scanner.next().toLowerCase();
		System.out.println(args[0]);
		String host  = args[0];
		Integer port = Integer.parseInt(args[1]);
		Integer nThread = Integer.parseInt(args[2]);
		Integer mode = args[3].toLowerCase().equals("fcfs")?FCFS:SFF;
		
		//System.out.println(args[3]);
		
		new MainThread(port, mode, nThread, host).start();
		
	}
	
	public void run(){
		
		while(true){
			Socket socket = null;
			try {
				socket = serverSocket.accept();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			new Thread(new MyThread(mode,socket,threadPoolExecutor)).start();;
			
			 System.out.println("线程池中线程数目："+threadPoolExecutor.getPoolSize()+"，队列中等待执行的任务数目："+
		             threadPoolExecutor.getQueue().size()
		             +"，已执行玩别的任务数目："+threadPoolExecutor.getCompletedTaskCount());
			
		}
	}
}
