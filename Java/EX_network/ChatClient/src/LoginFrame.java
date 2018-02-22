import java.awt.Dimension;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.net.Socket;
import java.net.UnknownHostException;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.border.EmptyBorder;

public class LoginFrame extends JFrame{
	private static final long serialVersionUID = 1L;
	public static void main(String[] args){
		new LoginFrame();
	}
	public LoginFrame(){
		Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
		int width = (int)screensize.getWidth();
		int height = (int)screensize.getHeight();
		
		
		this.setResizable(false);
		//this.setBackground(Color.white);
		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(width/2-200,height/2-150,400,300);
		JPanel contentPane=new JPanel();
		contentPane.setBorder(new EmptyBorder(5,5,5,5));
		contentPane.setLayout(null);
		setContentPane(contentPane);
		//this.add(contentPane);
		
		JLabel userNameLabel=new JLabel("UserName");
		userNameLabel.setBounds(60,60,90,20);
		contentPane.add(userNameLabel);
		JTextField userTextField=new JTextField();
		userTextField.setBounds(150,60,150,20);
		contentPane.add(userTextField);
		userTextField.setColumns(10);
		JLabel passWordLabel=new JLabel("Password");
		passWordLabel.setBounds(60,120,90,20);
		contentPane.add(passWordLabel);
		JTextField passWordTextField=new JTextField();
		passWordTextField.setBounds(150,120,150,20);
		contentPane.add(passWordTextField);
		passWordTextField.setColumns(10);
		
		JButton btnLogin=new JButton("Login");
		btnLogin.setBounds(150,200,100,25);
		add(btnLogin);
		

		this.setVisible(true);
		btnLogin.addActionListener(new ActionListener(){
			public void actionPerformed(ActionEvent arg0){
				try{
					Socket s=new Socket("localhost",4001);
					DataOutputStream dos=new DataOutputStream(s.getOutputStream());
					DataInputStream dis=new DataInputStream(s.getInputStream());
					if(userTextField.getText().equals("")||passWordTextField.getText().equals("")){
						
					}else{
						dos.writeUTF("101@"+userTextField.getText()+","+passWordTextField.getText());
						dos.flush();
						String feedback=dis.readUTF();
						System.out.println("receive from server:"+feedback);
						if(feedback.equals("success")){
							new MainFrame(s,userTextField.getText());
							setVisible(false);
						}else{
							JOptionPane.showMessageDialog(LoginFrame.this, feedback);
						}
					}
					
				}catch(UnknownHostException e){
					e.printStackTrace();
				}
				catch(IOException e){
					e.printStackTrace();
				}
			}
		});
		
	}
}
