package com.neu.view;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.Toolkit;

import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class MedicalInsuranceCenterGUI extends JPanel {	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/* Window width in pixels */
	static private int WIDTH = 620;

	/* Window height in pixels */
	static private int HEIGHT = 530;
	
	private JPanel mainContainer;
	private JButton personInformationMaintenance;
	private JButton unitInformationMaintenance;
	
	public static void main(String [] args){
		JFrame frame = new JFrame("个人基本信息维护");
		frame.setContentPane(new MedicalInsuranceCenterGUI());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(WIDTH, HEIGHT);
		frame.setResizable(true);
		frame.setVisible(true);
		Dimension s = Toolkit.getDefaultToolkit().getScreenSize();
		frame.setLocation(s.width / 2 - (int) (frame.getWidth() / 2), s.height / 2 - (int) (frame.getHeight() / 2));

	}
	
	public MedicalInsuranceCenterGUI(){
		super();
		personInformationMaintenance = new JButton("个人基本信息维护");
		unitInformationMaintenance = new JButton("单位基本信息维护");
		this.add(personInformationMaintenance,BorderLayout.NORTH);
		this.add(unitInformationMaintenance,BorderLayout.NORTH);
		
		mainContainer = new PersonInformationPanel();
		mainContainer.setBorder(BorderFactory.createTitledBorder("main"));
		
		this.add(mainContainer, BorderLayout.SOUTH);
		
		
	}
	
}
