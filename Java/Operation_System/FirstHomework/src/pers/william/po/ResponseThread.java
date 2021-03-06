package pers.william.po;

import java.io.IOException;
import java.io.PrintStream;
import java.net.Socket;

public class ResponseThread extends Thread {

	private Socket socket;
	private String fileName;

	public ResponseThread() {
		super();
	}

	public ResponseThread(Socket socket, String fileName) {
		super();
		this.socket = socket;
		this.fileName = fileName;
	}

	public Socket getSocket() {
		return socket;
	}

	public void setSocket(Socket socket) {
		this.socket = socket;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Override
	public String toString() {
		return "ResponseThread [socket=" + socket + ", fileName=" + fileName + "]";
	}
	
	public void run(){
		
		PrintStream writer;

		try {
			writer = new PrintStream(socket.getOutputStream());

			writer.println("response to client:"+socket+", task:"+fileName  + "finished!");
			writer.flush();
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
