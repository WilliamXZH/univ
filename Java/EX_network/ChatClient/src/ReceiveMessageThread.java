import java.io.DataInputStream;
import java.io.IOException;
import java.net.Socket;

public class ReceiveMessageThread extends Thread{
	Socket s;
	MainFrame main=null;
	ReceiveMessageThread(Socket ss,MainFrame mainframe){
		this.s=ss;
		this.main=mainframe;
	}
	public void run(){
		try {
			DataInputStream dis=new DataInputStream(s.getInputStream());
			while(true){
				String message=dis.readUTF();
				String []m1=message.split(";");
				for(int i=0;i<m1.length;i++){
					String []m2=m1[i].split("@");
					if(m2[0].equals("102")){
						String []m3=m2[2].split(",");
						main.comboBox.removeAllItems();
						for(int j=0;j<m3.length;j++){
							main.comboBox.addItem(m3[j]);
						}
					}else if(m2[0].equals("103")){
						main.textArea.append(m2[3]+" "+m2[1]+" sent you:"+m2[2]+"\r\n");
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
