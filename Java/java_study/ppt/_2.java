import javax.swing.*;
public class _2{
	public static void main(String[] args) {
		JFrame f = new JFrame(); 
		f.setLayout(new FlowLayout());
		JButton button1 = new JButton("Ok");
		JButton button2 = new JButton("Open");
		JButton button3 = new JButton("Close");
		button1.setFont(new Font("Serif", Font.BOLD, 45));
		button2.setFont(new Font("Serif", Font.BOLD, 45));
		button3.setFont(new Font("Serif", Font.BOLD, 45));
		f.add(button1);
		f.add(button2);
		f.add(button3);
		f.setSize(300,300); 
		f.setVisible(true);
	}
}
