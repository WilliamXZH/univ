import java.awt.Button;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.util.Date;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.border.EmptyBorder;

public class MainFrame extends JFrame{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Socket s;
	private String name;
	public JTextArea textArea;
	public JTextArea textArea_1;
	public JComboBox<String> comboBox;
	public JPanel contentPane;
	public JButton Button1,Button2,Button3;
	
//	public static void main(String[] args){
//		try {
//			new MainFrame(new Socket("localhost",4001),"123");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
	
	public MainFrame(Socket s, String text) {
		this.s=s;
		this.name=text;
		Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
		int width = (int)screensize.getWidth();
		int height = (int)screensize.getHeight();
		
		this.setBounds(width/2-300,height/2-200,600 , 400);
		this.setResizable(false);
		
		this.setName(text);
		this.setTitle("hello, "+text);

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		setContentPane(contentPane);
		
		JPanel messaging=new JPanel();
		messaging.setName("Instant Messaging");
		messaging.setBorder(BorderFactory.createTitledBorder("Instant Messaging"));
		messaging.setBounds(20, 10,550, 350);
		messaging.setLayout(null);
		contentPane.add(messaging);
		
		JLabel lblNewLabel = new JLabel("Recipient:");
		messaging.add(lblNewLabel);
		lblNewLabel.setFont(new Font("ÀŒÃÂ", Font.PLAIN, 16));
		lblNewLabel.setBounds(30, 20,90, 20);
		
		comboBox = new JComboBox<String>();
		comboBox.setBounds(130,20,380, 20);
		messaging.add(comboBox);
		
		textArea=new JTextArea();
		//textArea.setBounds(30,50,490,150);
		messaging.add(textArea);
		textArea.setEditable(false);
		textArea.setLineWrap(true);
		JScrollPane scroll=new JScrollPane(textArea);
		scroll.setBounds(30,50,490,150);
		messaging.add(scroll);
		
		Button1=new JButton("±Ì«È");
		Button1.setBounds(30,210,80,20);
		messaging.add(Button1);
		
		
		textArea_1=new JTextArea();
		textArea_1.setBounds(30,230,490,50);
		messaging.add(textArea_1);
		textArea.setLineWrap(true);
		JScrollPane scroll2=new JScrollPane(textArea_1);
		scroll2.setBounds(30, 230, 490, 50);
		messaging.add(scroll2);
		
		Button2=new JButton("Send");
		Button2.setBounds(130,300,100,30);
		messaging.add(Button2);
		Button2.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent ae){
					
				String from=name;
				String to=comboBox.getSelectedItem().toString();
				String content=textArea_1.getText();
				try{
					DataOutputStream dos=new DataOutputStream(s.getOutputStream());
					if(content.equals("")||content.equals(null)){
						//Button2.setText("Please input something.");
						/*try {
							Thread.sleep(1000);
							Button2.setToolTipText(null);
						} catch (InterruptedException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}*/
						
					}else{
							
						dos.writeUTF("103@"+from+","+to+","+content);
						dos.flush();
						textArea.append("To "+to+"("+new Date()+"):"+content+"\r\n");
						textArea_1.setText("");
					}
				}catch(IOException e){
					e.printStackTrace();
				}
			}
		});
		
		Button3=new JButton("Send Files");
		Button3.setBounds(320,300,100,30);
		messaging.add(Button3);
		
		this.setVisible(true);
		
		try{
			DataOutputStream dos=new DataOutputStream(s.getOutputStream());
			dos.writeUTF("102@");
			dos.flush();
			System.out.println("send to server:102");
		}catch(IOException e){
			e.printStackTrace();
		}
		new ReceiveMessageThread().start();
	}
	class ReceiveMessageThread extends Thread{
		public void run(){
			try {
				DataInputStream dis=new DataInputStream(s.getInputStream());
				while(true){
					String message=dis.readUTF();
					System.out.println("receive from server:"+message);
					String []m1=message.split(";");
					for(int i=0;i<m1.length;i++){
						String []m2=m1[i].split("@");
						if(m2[0].equals("102")){
							String []m3=m2[2].split(",");
							comboBox.removeAllItems();
							for(int j=0;j<m3.length;j++){
								comboBox.addItem(m3[j]);
							}
						}else if(m2[0].equals("103")){
							textArea.append(m2[3]+" "+m2[1]+" sent you:"+m2[2]+"\r\n");
						}
					}
				}
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}


}
