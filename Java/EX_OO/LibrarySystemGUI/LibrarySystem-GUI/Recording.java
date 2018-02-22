import java.awt.BorderLayout;
import java.awt.GridLayout;

import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

/*!Begin Snippet:file*/
/**
 * This class models a recording. It extends {@link CatalogItem} and
 * adds the following information:
 * <ol>
 * <li>the performer of the recording, a <code>String</code></li>
 * <li>the format of the recording, a <code>String</code></li>
 * </ol>
 *
 * @author iCarnegie
 * @version  1.0.0
 * @see CatalogItem
 */
public class Recording extends CatalogItem  {

	/* Performer of the recording. */
	private String  performer;

	/* Format of the recording. */
	private String  format;

	/**
	 * Constructs an <code>Recording</code> object.
	 *
	 * @param initialCode  the code of the catalog item.
	 * @param initialTitle  the title of the catalog item.
	 * @param initialYear  the year of the catalog item.
	 * @param initialPerformer  the performer of the recording.
	 * @param initialFormat  the format of the recording.
	 */
	public Recording(String initialCode, String initialTitle,
			int initialYear, String initialPerformer,
			String initialFormat)  {

		super(initialCode, initialTitle, initialYear);

		this.performer = initialPerformer;
		this.format = initialFormat;
	}

	/**
	 * Returns the performer of this recording.
	 *
	 * @return  the performer of this recording.
	 */
	public String  getPerformer()  {

		return  this.performer;
	}

	/**
	 * Returns the format of this recording.
	 *
	 * @return  the format of this recording.
	 */
	public String  getFormat()  {

		return  this.format;
	}

	/**
	 * Returns the string representation of this recording.
	 *
	 * @return  the string representation of this recording.
	 */
	public String toString()  {

		return  super.toString() + "_" + getPerformer() + "_"
		        + getFormat();
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
		JTextField performerTextField = new JTextField(this.getPerformer(), 17);
		JTextField formatTextField = 
			new JTextField(this.getFormat(), 17);
		
		codeTextField.setEditable(false);
		titleTextField.setEditable(false);
		yearTextField.setEditable(false);
		availableTextField.setEditable(false);
		performerTextField.setEditable(false);
		formatTextField.setEditable(false);

		JPanel leftPanel = new JPanel(new GridLayout(6, 1));

		leftPanel.add(new JLabel("Code: "));
		leftPanel.add(new JLabel("Title: "));
		leftPanel.add(new JLabel("Year: "));
		leftPanel.add(new JLabel("Performer: "));
		leftPanel.add(new JLabel("Formats: "));
		leftPanel.add(new JLabel("Available: "));

		JPanel centerPanel = new JPanel(new GridLayout(6, 1));

		centerPanel.add(codeTextField);
		centerPanel.add(titleTextField);
		centerPanel.add(yearTextField);
		centerPanel.add(performerTextField);
		centerPanel.add(formatTextField);
		centerPanel.add(availableTextField);

		panel.add(leftPanel, BorderLayout.WEST);
		panel.add(centerPanel, BorderLayout.CENTER);

		return panel;
	}
}
/*!End Snippet:file*/