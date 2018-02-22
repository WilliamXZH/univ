import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.List;

public class SendMessageThread extends Thread{
	Socket s=null;
	String name=null;
	MessageDAO messages=null;
	public SendMessageThread(Socket s, String name,MessageDAO ms) {
		this.s=s;
		this.name=name;
		this.messages=ms;
	}
	public void run(){
		DataOutputStream dos;
		try {
			dos = new DataOutputStream(s.getOutputStream());
			while(true){
				List<Message> myMessage=messages.getMyMessage(name);
				

				System.out.println();
				for(Message ms:messages.getMyMessage()){
					System.out.println(ms.toString());
				}
				
				StringBuffer buffer=new StringBuffer();
				for(int i=0;i<myMessage.size();i++){
					Message m=myMessage.get(i);
					buffer.append(m.getMessageType()+"@"+m.getFrom()+"@"+m.getContent()+"@"+m.getSendtime()+";");
				}
				if(buffer.length()>0){
					String strMessage=buffer.substring(0,buffer.length()-1);
					dos.writeUTF(strMessage);
					dos.flush();
					System.out.println("send:"+strMessage);
				}
				messages.removeMyMessage(myMessage);
				try{
					Thread.sleep(1000);
				}catch(InterruptedException e){
					e.printStackTrace();
				}
			}
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
	}
}
