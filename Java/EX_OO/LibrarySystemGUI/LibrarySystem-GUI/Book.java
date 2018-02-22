import java.awt.BorderLayout;
import java.awt.GridLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

/*!Begin Snippet:file*/
/**
 * This class models a book. It extends {@link CatalogItem} and
 * adds the following information:
 * <ol>
 * <li>the author of the book, a <code>String</code></li>
 * <li>the number of pages in the book, an <code>int</code></li>
 * </ol>
 *
 * @author iCarnegie
 * @version  1.0.0
 * @see CatalogItem
 */
public class Book extends CatalogItem  {

	/* Author of the book.*/
	private String  author;

	/* Number of pages in the book.*/
	private int  numberOfPages;

	/**
	 * Constructs a <code>Book</code> object.
	 *
	 * @param initialCode  the code of the book.
	 * @param initialTitle  the title of the book.
	 * @param initialYear  the year the book was published.
	 * @param initialAuthor  the author of the book.
	 * @param initialNumberOfPages  the number of pages in the book.
	 */
	public Book(String initialCode, String initialTitle,
	 		int initialYear, String initialAuthor,
			int initialNumberOfPages) {

		super(initialCode, initialTitle, initialYear);

		this.author = initialAuthor;
		this.numberOfPages = initialNumberOfPages;
	}

	/**
	 * Returns the author of this book.
	 *
	 * @return  the author of this book.
	 */
	public String  getAuthor()  {

		return  this.author;
	}

	/**
	 * Returns the number of pages in this book.
	 *
	 * @return  the number of pages in this book.
	 */
	public int  getNumberOfPages()  {

		return  this.numberOfPages;
	}

	/**
	 * Returns the string representation of this book.
	 *
	 * @return  the string representation of this book.
	 */
	public String toString()  {

		return  super.toString() + "_" + getAuthor() + "_"
		        + getNumberOfPages();
	}
	
	/**
	 * Obtains a {@link JPanel} object with the information of this CatalogItem.
	 *
	 * @return a <code>JPanel</code> with the information of this CatalogItem.
	 */
	public JPanel getPanel() {

		JPanel panel = new JPanel(new BorderLayout());

		JTextField codeTextField = new JTextField(getCode(), 17);
		JTextField titleTextField = new JTextField(this.getTitle(), 17);
		JTextField yearTextField =
			new JTextField(Integer.toString(getYear()), 17);
		JTextField availableTextField = 
			new JTextField(Boolean.toString(isAvailable()), 17);
		JTextField authorTextField = new JTextField(getAuthor(), 17);
		JTextField numberOfPagesTextField = 
			new JTextField(Integer.toString(getNumberOfPages()), 17);
		
		codeTextField.setEditable(false);
		titleTextField.setEditable(false);
		yearTextField.setEditable(false);
		availableTextField.setEditable(false);
		authorTextField.setEditable(false);
		numberOfPagesTextField.setEditable(false);

		JPanel leftPanel = new JPanel(new GridLayout(6, 1));

		leftPanel.add(new JLabel("Code: "));
		leftPanel.add(new JLabel("Title: "));
		leftPanel.add(new JLabel("Year: "));
		leftPanel.add(new JLabel("Author: "));
		leftPanel.add(new JLabel("NumberOfPages: "));
		leftPanel.add(new JLabel("Available: "));

		JPanel centerPanel = new JPanel(new GridLayout(6, 1));

		centerPanel.add(codeTextField);
		centerPanel.add(titleTextField);
		centerPanel.add(yearTextField);
		centerPanel.add(authorTextField);
		centerPanel.add(numberOfPagesTextField);
		centerPanel.add(availableTextField);

		panel.add(leftPanel, BorderLayout.WEST);
		panel.add(centerPanel, BorderLayout.CENTER);

		return panel;
	}
}
/*!End Snippet:file*/