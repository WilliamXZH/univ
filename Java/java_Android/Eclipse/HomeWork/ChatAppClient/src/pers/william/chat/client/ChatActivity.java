package pers.william.chat.client;


import java.io.BufferedReader;

import java.io.InputStreamReader;

import java.net.BindException;

import java.net.Socket;


import android.app.Activity;

import android.os.Bundle;

import android.os.Handler;

import android.os.Message;

import android.view.View;

import android.widget.Button;

import android.widget.EditText;

import chap7.chat.R;


public class ChatActivity extends Activity {

	
	private int port = 12345;
	
	private String Address="127.0.0.1";
	
	Socket socket;
	
	Handler handler;
	
	
	/** Called when the activity is first created. */
	
	@Override
	
	public void onCreate(Bundle savedInstanceState) {
		
		super.onCreate(savedInstanceState);
		
		setContentView(R.layout.main);
		
		final EditText name = (EditText) findViewById(R.id.name);
		
		final EditText sentence = (EditText) findViewById(R.id.sentence);
		
		final Button send = (Button) findViewById(R.id.send);
		
		final EditText show = (EditText) findViewById(R.id.show);
		
		
		while(true){	
			
			try {
				
				socket = new Socket(Address, port);
				
				this.new ChatThread(socket).start();
				
				break;
			
			}catch(BindException e){
				
				port+=10;
				
				e.printStackTrace();
			
			} catch (Exception e) {
				
				e.printStackTrace();
			
			}
		
		}

		
		send.setOnClickListener(new View.OnClickListener() {
			
			public void onClick(View v) {
				
				String s1 = name.getText().toString();
				
				String s2 = sentence.getText().toString();
				
				String s = s1 + ": " + s2+"\n";
				
				if (socket != null) {
					
					try {
						
						socket.getOutputStream().write(s.getBytes("utf-8"));
					
					} catch (Exception e) {
						
						e.printStackTrace();
					
					}
					
					sentence.setText("");
				
				}
			
			}
		
		});
		
		handler = new Handler() {

			public void handleMessage(Message msg) {
				
				super.handleMessage(msg);
				
				String tmp = show.getText().toString();
				
				show.setText(tmp+"\n\n"+msg.getData().getString("chat"));
			
			}
		
		};
	
	}

	
	class ChatThread extends Thread {

		
		Socket s;

		
		public ChatThread(Socket client) {
			
			s = client;
		
		}

		
		public void run() {
			
			try {
				
				BufferedReader in = new BufferedReader(new InputStreamReader(
s.getInputStream(), "utf-8"));
				
				while (true) {
					
					String sentence = in.readLine();
					
					if (sentence != null){
						
						Bundle b = new Bundle();
						
						b.putString("chat", sentence);
						
						Message msg = Message.obtain();
						
						msg.setData(b);
						
						handler.sendMessage(msg);
					
					}
				
				}
			
			} catch (Exception e) {
				
				e.printStackTrace();
			
			}
		
		}
	
	}

}