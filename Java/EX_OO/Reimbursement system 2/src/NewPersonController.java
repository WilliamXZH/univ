
import java.net.URL;
import java.text.ParseException;
import java.util.Date;
import java.util.ResourceBundle;

import base.Drug;
import base.Person;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import tool.DateFormatter;

public class NewPersonController implements Initializable {

	@FXML
	private GridPane newPersonPanel;
	@FXML
	private TextField text1, text2, text3;
	@FXML
	private ComboBox<String> choice1, choice2;
	@FXML
	private DatePicker datePicker;
	@FXML
	private Button personNoButton,personOkButton;
	@Override
	public void initialize(URL url, ResourceBundle rb) {
		initChoice();
	}

	private void initChoice() {
		choice1.setItems(FXCollections.observableArrayList("身份证","护照"));
		choice2.setItems(FXCollections.observableArrayList("男", "女"));
	}

	public void okClicked(ActionEvent event) {

	}

	public void noClicked(ActionEvent event) {
		newPersonPanel.getScene().getWindow().hide();
	}
	
	public Person getPerson() {
		Date birthday=DateFormatter.localToDate(datePicker.getValue());
		Person person = new Person();
		person.setHospitalCode(text3.getText());
		person.setName(text2.getText());
		person.setID(text1.getText());
		person.setUnitName(choice1.getValue());
		person.setGender(choice2.getValue());
		person.setBirthday(birthday);
		newPersonPanel.getScene().getWindow().hide();
		return person;
	}

	public boolean hasNull() {
		if ((choice1.getValue()==null||choice2.getValue()==null||choice1.getValue().equals("null")) || (choice2.getValue().equals("null"))
				|| (datePicker.getValue()==null || (text1.getText().equals("null"))
				|| (text2.getText().equals("null")) || (text3.getText().equals("null"))
				|| (text1.getText().equals(""))
				|| (text2.getText().equals("")) 
				|| (text3.getText().equals(""))))  {
			return true;
		} else
			return false;
	}

	public void alartNull() {
		Alert alert = new Alert(AlertType.WARNING, "请全部填写！", ButtonType.CLOSE);
		alert.show();
	}

	public void initModify(Person selecetedPerson) {
		text1.setText(selecetedPerson.getID());
		text2.setText(selecetedPerson.getName());
		text3.setText(selecetedPerson.getHospitalCode());
		choice1.setValue(selecetedPerson.getUnitName());
		choice2.setValue(selecetedPerson.getGender());
		try {
			datePicker.setValue(DateFormatter.dateToLocal(DateFormatter.stringToDay(selecetedPerson.getBirthday())));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
