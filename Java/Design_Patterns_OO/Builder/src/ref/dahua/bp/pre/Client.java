package ref.dahua.bp.pre;

import java.awt.Graphics;

import javax.swing.JFrame;

public class Client extends JFrame{
	
	public Client(){

		setSize(600,400);
//		setSize(0,0);
//		setDefaultCloseOperation(EXIT_ON_CLOSE);
	}
	
	public void paint(Graphics g) {
		// TODO Auto-generated method stub
		super.paint(g);
		PersonDirector pdThin = new PersonDirector(
				new PersonThinBuilder(g));
		pdThin.createPerson();
	}

	public static void main(String[] args) {
		Client c = new Client();
		c.setVisible(true);
	}
	
}
