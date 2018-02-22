import java.util.Date;

public class Message {
	private String Type=null;
	private String From=null;
	private String Content=null;
	private String To=null;
	private Date Sendtime=null;
	Message(){
		
	}
	public String getMessageType() {
		return this.Type;
	}
	public String getFrom(){
		return this.From;
	}
	public String getContent() {
		return this.Content;
	}
	public String getTo(){
		return this.To;
	}
	public Date getSendtime() {
		return this.Sendtime;
	}

	public void setMessageType(String string) {
		this.Type=string;
		
	}

	public void setFrom(String string) {
		this.From=string;
	}

	public void setTo(String string) {
		this.To=string;
	}

	public void setContent(String string) {
		this.Content=string;
	}

	public void setSendtime(Date date) {
		this.Sendtime=date;
	}
	public String toString(){
		return this.Type+"@"+this.From+"@"+this.To+"@"+this.Content;
	}



}
