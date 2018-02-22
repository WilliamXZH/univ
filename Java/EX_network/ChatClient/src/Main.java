import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.border.EmptyBorder;
import javax.swing.JLabel;
import java.awt.Font;
import java.awt.Toolkit;
import java.net.Socket;

import javax.swing.JTextField;
import javax.swing.JComboBox;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.io.DataOutputStream;
import java.io.IOException;
import java.awt.event.ActionEvent;
import javax.swing.JTextArea;
import java.awt.Color;
import java.awt.Dimension;

public class Main extends JFrame {

	public JPanel contentPane;
	public JTextField textField_1;
	public JComboBox comboBox;
	public JTextArea textArea;
	/**
	 * Launch the application.
	 */
//	public static void main(String[] args) {
//		EventQueue.invokeLater(new Runnable() {
//			public void run() {
//				try {
//					MainFrame frame = new MainFrame();
//					frame.setVisible(true);
//				} catch (Exception e) {
//					e.printStackTrace();
//				}
//			}
//		});
//	}

	/**
	 * Create the frame.
	 */


	public Main(Socket ss, String text) {
		
		
		Socket s=ss;
		try {
			DataOutputStream dos=new DataOutputStream(s.getOutputStream());
			dos.writeUTF("102|");
			dos.flush();
			System.out.println("102");
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		


		Dimension screensize = Toolkit.getDefaultToolkit().getScreenSize();
		int width = (int)screensize.getWidth();
		int height = (int)screensize.getHeight();
		
		this.setBounds(width/2-400,height/2-300,800 , 600);
		
		this.setName(text);
		this.setTitle(text);		
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(null);
		setContentPane(contentPane);
		
		JLabel lblNewLabel = new JLabel("Recipient:");
		lblNewLabel.setFont(new Font("ËÎÌו", Font.PLAIN, 16));
		lblNewLabel.setBounds(87, 20, 91, 24);
		contentPane.add(lblNewLabel);
		
		comboBox = new JComboBox();
		comboBox.setBounds(200, 21, 289, 24);
		contentPane.add(comboBox);
		
		
		
		JButton btnNewButton = new JButton("\u8868\u60C5");
		btnNewButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton.setBounds(85, 248, 93, 23);
		contentPane.add(btnNewButton);
		
		textField_1 = new JTextField();
		textField_1.setBounds(87, 281, 491, 60);
		contentPane.add(textField_1);
		textField_1.setColumns(10);
		
		JButton btnNewButton_1 = new JButton("Send");
		btnNewButton_1.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				String from=Main.this.getName();
				String to =Main.this.comboBox.getSelectedItem().toString();
				String content =textField_1.getText();
				try {
					DataOutputStream dos=new DataOutputStream(s.getOutputStream());
					dos.writeUTF("103|"+from+","+to+","+content);
					dos.flush();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			}
		});
		btnNewButton_1.setBounds(165, 351, 93, 23);
		contentPane.add(btnNewButton_1);
		
		JButton btnNewButton_2 = new JButton("SendFile");
		btnNewButton_2.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
			}
		});
		btnNewButton_2.setBounds(317, 351, 93, 23);
		contentPane.add(btnNewButton_2);
		
		textArea = new JTextArea();
		textArea.setLineWrap(true);
		textArea.setBounds(97, 54, 481, 184);
		contentPane.add(textArea);
		this.setVisible(true);
	}
}
