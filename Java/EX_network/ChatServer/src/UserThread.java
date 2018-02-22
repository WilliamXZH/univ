import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Date;
import java.util.List;


public class UserThread  extends Thread{
	Socket s=null;
	DataInputStream dis=null;
	DataOutputStream dos=null;
	String name=null;
	private static UserinfoDAO users=new UserinfoDAO();
	private static MessageDAO messages=new MessageDAO();
	
	UserThread(Socket s){
		this.s=s;
	}
	public void run(){
		
		try{
			dis=new DataInputStream(s.getInputStream());
			dos=new DataOutputStream(s.getOutputStream());
			while(true){
					
				String message=dis.readUTF();
				System.out.println("receive:"+message);
				if(message.startsWith("101")){
					String content=StringUtils.getContent(message);
					name=content.split(",")[0];
					String pass=content.split(",")[1];
					if(users.validateUser(name,pass)){
						System.out.println(users.getUserinfo(name).getstatus());
						if(users.getUserinfo(name).getstatus()){
							dos.writeUTF("the user have logined.");
							System.out.println("the user have logined.");
						}
						else{
							users.getUserinfo(name).setstatus(true);
							dos.writeUTF("success");
							System.out.println("send:success");
							SendMessageThread send=new SendMessageThread();
							send.start();
						}
					}else{
						dos.writeUTF("failure!");
						System.out.println("failure");
					}
					dos.flush();
				//}else if(StringUtils.getCode(message).equals("102")){
				}else if(message.startsWith("102")){
					List<Userinfo> usersList=users.getUserList();
					StringBuffer buffer=new StringBuffer();
					for(int i=0;i<usersList.size();i++){
						Userinfo u=usersList.get(i);
						buffer.append(u.getName()+",");
					}
					String userstr=buffer.substring(0,buffer.length()-1);
					Message m=new Message();
					m.setMessageType("102");
					m.setFrom("server");
					m.setContent(userstr);
					m.setSendtime(new Date());
					m.setTo(name);
					messages.add(m);
				//}else if(StringUtils.getCode(message).equals("103")){
				}else if(message.startsWith("103")){
					String content=StringUtils.getContent(message);
					Message m=new Message();
					m.setFrom(content.split(",")[0]);
					m.setTo(content.split(",")[1]);
					m.setContent(content.split(",")[2]);
					m.setSendtime(new Date());
					m.setMessageType("103");
					messages.add(m);
				}else{
					System.out.println("error:"+message);
				}
			}
		}catch(Exception e){

			users.getUserinfo(name).setstatus(false);
			try {
				s.close();
			} catch (IOException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
	}
	class SendMessageThread extends Thread{
		public void run(){
			DataOutputStream dos;
			try {
				dos = new DataOutputStream(s.getOutputStream());
				while(true){
					List<Message> myMessage=messages.getMyMessage(name);
					

//					System.out.println();
//					for(Message ms:messages.getMyMessage()){
//						System.out.println(ms.toString());
//					}
//					
					 
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

}
