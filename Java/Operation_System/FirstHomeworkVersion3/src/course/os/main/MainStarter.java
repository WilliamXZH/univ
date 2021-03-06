package course.os.main;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;

import course.os.server.ServerThread;

public class MainStarter {

	public static void main(String[] args) throws IOException{
		
		ServerSocket serverSocket = new ServerSocket(9999);
		
		new Thread(new mainThread(serverSocket)).start();
		
	}
	
}

class mainThread implements Runnable{
	
	private ServerSocket serverSocket;
	
	public mainThread(ServerSocket ss) {
		this.serverSocket = ss;
	}

	@Override
	public void run() {
		
		System.out.println("Enter the main thread:");
		while(true){
			
			try {
				Socket socket = serverSocket.accept();
				
				new Thread(new ServerThread(socket)).start();
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			
		}
		
	}
}
