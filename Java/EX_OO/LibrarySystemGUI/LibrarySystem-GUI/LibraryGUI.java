import java.awt.*;
import java.io.*;
import javax.swing.*;
import javax.swing.event.*;
import java.awt.event.*;
import java.util.*;

/**
 * Library System.
 *
 * @author iCarnegie
 * @version 1.1.0
 * @see CatalogItem
 * @see Book
 * @see Recording
 * @see Catalog
 * @see Borrower
 * @see BorrowerDatabase
 * @see BorroweredItems
 * @see CatalogLoader
 * @see FileCatalogLoader
 * @see DataFormatException
 * @see BorrowersFormatter
 * @see PlainTextBorrowersFormatter
 * @see HTMLBorrowersFormatter
 * @see XMLBorrowersFormatter
 * 
 */
public class LibraryGUI extends JPanel{
	/* Standar error stream */
	static private PrintWriter  stdErr = new  PrintWriter(System.err, true);

	/* Window width in pixels */
	static private int WIDTH = 850;

	/* Window height in pixels */
	static private int HEIGHT = 600;

	/* Size of the catalog list cell in pixels */
	static private int CATALOG_CELL_SIZE = 50;

	/* Visible rows in catalog list */
	static private int CATALOG_LIST_ROWS = 14;

	/* Size of the borrower item cell in pixels */
	static private int BORROWER_CELL_SIZE = 100;

	/* Visible rows in borrower item */
	static private int BORROWER_LIST_ROWS = 6;

	/* Size borrower ID text field */
	static private int BORROWER__TEXTFIELD_SIZE = 5;

	/* Rows in status text area rows */
	static private int STATUS_ROWS = 10;

	/* Rows in status text area cols */
	static private int STATUS_COLS = 40;

	private JList catalogList;
	private JList borrowerItemList;
	private JButton addButton;
	private JButton removeButton;
	private JButton registerBorrowersButton;
	private JButton displayBorrowersDBButton;
	private JButton saveBorrowersDBButton;
	private JButton displayBorrowerItemButton;
	private JPanel catalogItemPanel;
	private JLabel borrowerLabel;
	private JTextField borrowerTextField;
	private JTextArea statusTextArea;
	private JRadioButton  plainRadioButton;
	private JRadioButton  HTMLRadioButton;
	private JRadioButton  XMLRadioButton;

	private JFileChooser  fileChooser;

	private Catalog  catalog;
	private BorrowerDatabase borrowerDB;
	private Borrower borrower;
	private BorrowersFormatter borrowersFormatter;
	
	/**
	 * Loads a catalog and starts the application.
	 *
	 * @param args  String arguments.  Not used.
	 * @throws IOException if there are errors in the loading the catalog.
	 */
	public static void  main(String[]  args) throws IOException {

		String filename = "";

		if (args.length != 1) {
			filename = "catalog.dat";
		} else {
			filename = args[0];
		}
		try {
			Catalog catalog =
				(new FileLibraryCatalogLoader()).loadCatalog(filename);

			JFrame frame = new JFrame("Library System");

			frame.setContentPane(new LibraryGUI(catalog));
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			frame.setSize(WIDTH, HEIGHT);
			frame.setResizable(true);
			frame.setVisible(true);
			
			

		} catch (FileNotFoundException fnfe) {
			stdErr.println("The file does not exist");

			System.exit(1);

		} catch (DataFormatException dfe) {
			stdErr.println("The file contains malformed data: "
			               + dfe.getMessage());

			System.exit(1);
		}
	}
	
	/*
	 * Loads a BorrowerDatabase object.
	 */
	private BorrowerDatabase loadBorrowers(Catalog catalog) {

		BorrowerDatabase borrowerDB = new BorrowerDatabase();

		Borrower borrower = new Borrower("ID001", "James Addy");

		borrower.getBorrowedItems().addItem(
				catalog.getItem("B003"));
		borrower.getBorrowedItems().addItem(
				catalog.getItem("R001"));
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B012"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID002", "John Doust");
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID003", "Constance Foster");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B006"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID004", "Harold Gurske");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B002"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID005", "Mary A. Rogers");
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID006", "Laura Novelle");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B007"));
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B009"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID007", "David M. Prescott");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B011"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID008", "Francis Matthews");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("R003"));
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B005"));
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID009", "Thomas Ferris");
		borrowerDB.addBorrower(borrower);

		borrower = new Borrower("ID010", "John Johnson");
		borrower.getBorrowedItems().addItem(
				catalog.getItem("B004"));
		borrowerDB.addBorrower(borrower);

		return borrowerDB;
	}

	/**
	 * Instantiates the components and arranges them in a window.
	 *
	 * @param initialCatalog a product catalog.
	 */
	public  LibraryGUI(Catalog initialCatalog) {

		// create the components
		catalogList = new JList();
		borrowerItemList = new JList();
		catalogList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		catalogList.setVisibleRowCount(CATALOG_LIST_ROWS);
		catalogList.setFixedCellWidth(CATALOG_CELL_SIZE);
		borrowerItemList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
		borrowerItemList.setVisibleRowCount(BORROWER_LIST_ROWS);
		borrowerItemList.setFixedCellWidth(BORROWER_CELL_SIZE);
		
		addButton = new JButton("Add Borrower Item");
		displayBorrowerItemButton = new JButton("Display Borrower Item");
		removeButton = new JButton("Remove Borrower Item");
		registerBorrowersButton = new JButton("Register Borrowered Items");
		displayBorrowersDBButton = new JButton("Display Borrower");
		saveBorrowersDBButton = new JButton("Save Borrower");
		borrowerLabel = new JLabel("Borrower ID:");
		borrowerTextField = new JTextField("", BORROWER__TEXTFIELD_SIZE);
				
		statusTextArea = new JTextArea(STATUS_ROWS, STATUS_COLS);
		statusTextArea.setEditable(false);
		plainRadioButton = new JRadioButton("Plain", true);
		HTMLRadioButton = new JRadioButton("HTML");
		XMLRadioButton = new JRadioButton("XML");

		ButtonGroup group = new ButtonGroup();

		group.add(plainRadioButton);
		group.add(HTMLRadioButton);
		group.add(XMLRadioButton);

		// Product Information panel
		catalogItemPanel = new JPanel();
		catalogItemPanel.setBorder(
				BorderFactory.createTitledBorder("Catalog Item Information"));

		// Catalog panel
		JPanel catalogPanel = new JPanel();

		catalogPanel.setBorder(BorderFactory.createTitledBorder("Catalog"));
		catalogPanel.add (
			new JScrollPane(catalogList,
				JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
				JScrollPane.HORIZONTAL_SCROLLBAR_NEVER));

		// "Add catalog item" panel
		JPanel centralPanel = new JPanel(new BorderLayout());
		JPanel addPanel = new JPanel(new GridLayout(3, 1));
		JPanel borrowerPanel = new JPanel();

		borrowerPanel.add(borrowerLabel);
		borrowerPanel.add(borrowerTextField);
		addPanel.add(borrowerPanel);
		addPanel.add(displayBorrowerItemButton);
		addPanel.add(addButton);
		centralPanel.add(catalogItemPanel, BorderLayout.CENTER);
		centralPanel.add(addPanel, BorderLayout.SOUTH);

		// Borrowered item panel
		JPanel borrowerItemPanel = new JPanel(new BorderLayout());

		borrowerItemPanel.setBorder(BorderFactory.createTitledBorder("BorroweredItem"));

		JPanel buttonsPanel = new JPanel(new GridLayout(2, 1));

		buttonsPanel.add(removeButton);
		buttonsPanel.add(registerBorrowersButton);
		borrowerItemPanel.add(new JScrollPane(borrowerItemList,
			JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,
			JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED), BorderLayout.CENTER);
		borrowerItemPanel.add(buttonsPanel, BorderLayout.SOUTH);

		// Status panel
		JPanel bottomPanel = new JPanel(new BorderLayout());

		bottomPanel.setBorder(BorderFactory.createTitledBorder("Status"));

		JPanel borrowersDBButtonsPanel = new JPanel(new GridLayout(1, 5));

		borrowersDBButtonsPanel.add(plainRadioButton);
		borrowersDBButtonsPanel.add(HTMLRadioButton);
		borrowersDBButtonsPanel.add(XMLRadioButton);
		borrowersDBButtonsPanel.add(displayBorrowersDBButton);
		borrowersDBButtonsPanel.add(saveBorrowersDBButton);
		bottomPanel.add (new JScrollPane(statusTextArea,
			JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED,
			JScrollPane.HORIZONTAL_SCROLLBAR_AS_NEEDED), BorderLayout.CENTER);
		bottomPanel.add(borrowersDBButtonsPanel, BorderLayout.SOUTH);

		// arrange panels in window
		setLayout(new BorderLayout());
		add(catalogPanel, BorderLayout.WEST);
		add(centralPanel, BorderLayout.CENTER);
		add(borrowerItemPanel, BorderLayout.EAST);
		add(bottomPanel, BorderLayout.SOUTH);

		// start listening for list and buttons events
		catalogList.addListSelectionListener(new DisplayCatalogListener());
		displayBorrowerItemButton.addActionListener(new DisplayBorrowerItemListener());
		addButton.addActionListener(new AddListener());
		removeButton.addActionListener(new RemoveListener());
		registerBorrowersButton.addActionListener(new RegisterBorrowerListener());
		displayBorrowersDBButton.addActionListener(new DisplayBorrowerListener());
		saveBorrowersDBButton.addActionListener(new SaveBorrowerListener());
		plainRadioButton.addActionListener(new PlainListener());
		HTMLRadioButton.addActionListener(new HTMLListener());
		XMLRadioButton.addActionListener(new XMLListener());

		// populate the product catalog
		catalog = initialCatalog;
		catalogList.setListData(catalog.getCodes());
		
		borrowerDB = new BorrowerDatabase();
		borrowersFormatter = PlainTextBorrowersFormatter.getSingletonInstance();
		fileChooser = new JFileChooser();
		
		borrowerDB = loadBorrowers(catalog);
		
	}

	/**
	 * This inner class handles list-selection events.
	 */
	class DisplayCatalogListener implements ListSelectionListener {

		/**
		 * Displays the information of the selected catalog item.
		 *
		 * @param event  the event object.
		 */
		public void valueChanged(ListSelectionEvent event) {

			if (! catalogList.getValueIsAdjusting()) {

				String code = (String) catalogList.getSelectedValue();
				CatalogItem catalogItem = catalog.getItem(code);

				catalogItemPanel.removeAll();
				catalogItemPanel.setVisible(false);                   // Use this
				catalogItemPanel.add(catalogItem.getPanel()); // the panel
				catalogItemPanel.setVisible(true);                    // correctly

				statusTextArea.setText("Catalog Item " + code
				                       + " has been displayed");
			}
		}
	}

	/**
	 * This inner class processes <code>displayBorrowerItemButton</code> events.
	 */
	class DisplayBorrowerItemListener implements ActionListener {

		/**
		 * Display borrower items to the current borrower.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {
			
			String borrowerID = borrowerTextField.getText().trim();
									
			try{			
				
				if(borrowerDB.getBorrower(borrowerID) == null){
					
					statusTextArea.setText("Please enter a borrower code.");
					
				} else {
					borrower = borrowerDB.getBorrower(borrowerID);
					borrowerItemList.setListData(borrower.getBorrowedItems().getItems());
					statusTextArea.setText("The borrower item of " + borrower.getId() + " has been displayed.");
				}
				
			} catch(NumberFormatException numberFormatException) {
				
				statusTextArea.setText("Please enter an borrower ID.");
			
			} 		
		}
	}

	/**
	 * This inner class processes <code>addModifyButton</code> events.
	 */
	class AddListener implements ActionListener {

		/**
		 * Adds an order item to the current order.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {
			
			String selectedCatalog = (String)catalogList.getSelectedValue();
			CatalogItem selectedItem = catalog.getItem(selectedCatalog);
						
			try{
				String borrowerID = borrowerTextField.getText().trim();
				borrower = borrowerDB.getBorrower(borrowerID);
				
				if(borrower == null){
					
					statusTextArea.setText("Please enter a borrower code.");
					
				} else if(catalogList.getSelectedValue() == null){
					
					statusTextArea.setText("Please select a catalog item from the catalog list.");
				
				} else if(selectedItem.isAvailable() == false) {
				
					statusTextArea.setText("The catalog item has been borrowered.");
					
				} else {
					
					borrower.getBorrowedItems().addItem(selectedItem);
					borrowerItemList.setListData(borrower.getBorrowedItems().getItems());
					statusTextArea.setText("The catalog item has been added.");
				}
				
								
			} catch(NumberFormatException numberFormatException) {
				
				statusTextArea.setText("Please enter an integer.");
			
			} 		
		}
	}

	/**
	 * This inner class processes <code>removeButton</code> events.
	 */
	class RemoveListener implements ActionListener {

		/**
		 * Removes an order item from the current order.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {
			
			borrower = borrowerDB.getBorrower(borrowerTextField.getText().trim());
			
			if(borrower == null){
				
				statusTextArea.setText("Please input a borrower code.");
				
			}else if(borrower.getBorrowedItems().getNumberOfItems() == 0) {
				
				statusTextArea.setText("The borrower has not borrowered any catalog item.");
			
			} else if(borrowerItemList.getSelectedValue() == null) {
			
				statusTextArea.setText("Please select an item from the borrower item list.");
				
			} else {
				
				int index = borrowerItemList.getSelectedIndex();
				CatalogItem catalogItems[] = borrower.getBorrowedItems().getItems();
				borrower.getBorrowedItems().removeItem(catalogItems[index]);
				borrowerItemList.setListData(borrower.getBorrowedItems().getItems());
			}
			

		}
	}

	/**
	 * This inner class processes <code>registerSaleButton</code> button events.
	 */
	class RegisterBorrowerListener implements ActionListener {

		/**
		 * Registers the sale of the current order.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			statusTextArea.setText("The borrower item has been registered.");
		
		}
	}

	/**
	 * This inner class processes <code>displaySalesButton</code>events.
	 */
	class DisplayBorrowerListener implements ActionListener {

		/**
		 * Displays the sales information.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			if (borrowerDB.getNumberOfBorrowers() == 0) {
				statusTextArea.setText("No borrower.");
			} else {
				statusTextArea.setText(borrowersFormatter.formatBorrowers(borrowerDB));
			}
		}
	}

	/*
	 * This inner class processes <code>saveSalesButton</code>  events.
	 */
	class SaveBorrowerListener implements ActionListener {

		/**
		 * Saves the sales informations in a file.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			fileChooser = new JFileChooser();
			int result = fileChooser.showSaveDialog(LibraryGUI.this);
	
			if(result == JFileChooser.APPROVE_OPTION) {
				try{
					
					File file = fileChooser.getSelectedFile(); 
					PrintWriter writer = new PrintWriter(
							new FileWriter(file));
					String formatString = "";
					
					formatString = borrowersFormatter.formatBorrowers(borrowerDB);
					
					writer.print(formatString);
					writer.close();
					statusTextArea.setText("The borrowers information has been saved.");
					
				} catch(IOException ioException) {
					
					stdErr.println(ioException);
					stdErr.flush();
					
				}
			}
		}
	}

	/*
	 * This inner class processes <code>plainRadioButton</code> events.
	 */
	class PlainListener implements ActionListener {

		/**
		 * Sets the sales formatter to plain text.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			borrowersFormatter =
				PlainTextBorrowersFormatter.getSingletonInstance();
		}
	}

	/*
	 * This inner class processes <code>HTMLRadioButton</code> events.
	 */
	class HTMLListener implements ActionListener {

		/**
		 * Sets the sales formatter to HTML.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			borrowersFormatter = HTMLBorrowersFormatter.getSingletonInstance();
		}
	}

	/*
	 * This inner class processes <code>XMLRadioButton</code> events.
	 */
	class XMLListener implements ActionListener {

		/**
		 * Sets the sales formatter to XML.
		 *
		 * @param event  the event object.
		 */
		public void actionPerformed(ActionEvent event) {

			borrowersFormatter = XMLBorrowersFormatter.getSingletonInstance();
		}
	}

}
