import java.util.ArrayList;
import java.util.List;

public class MessageDAO {
	List<Message> MyMessage=new ArrayList<Message>();
	
	public  List<Message> getMyMessage(String name) {
		List<Message> messages=new ArrayList<Message>();
		for(Message ms:MyMessage){
			if(ms.getTo().equals(name)){
				messages.add(ms);
			}
		}
		return messages;
	}
	public void add(Message s){
		MyMessage.add(s);
	}
//	private Message getMessage(String name){
//		for(Message ms:MyMessage){
//			if(name.equals(ms.getTo())){
//				return ms;
//			}
//		}
//		return null;
//	}
	public void removeMyMessage(List<Message> s){
		for(Message ms:s){
			MyMessage.remove(ms);
		}
	}
	public List<Message> getMyMessage() {
		return this.MyMessage;
	}

}
