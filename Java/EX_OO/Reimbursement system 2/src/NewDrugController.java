
import java.net.URL;
import java.util.ResourceBundle;

import base.Drug;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;

public class NewDrugController implements Initializable {

	private Drug drug;
	@FXML
	private GridPane newPanel;
	@FXML
	private TextField text1, text2, text3, text4, text5;
	@FXML
	private ComboBox<String> choice1, choice2, choice3;

	@Override
	public void initialize(URL url, ResourceBundle rb) {
		initChoice();
	}

	private void initChoice() {
		choice1.setItems(FXCollections.observableArrayList("一级医院", "二级医院", "三级医院", "社区医院"));
		choice2.setItems(FXCollections.observableArrayList("是", "否"));
		choice3.setItems(FXCollections.observableArrayList("是", "否"));
	}

	public void okClicked(ActionEvent event) {

	}

	public void noClicked(ActionEvent event) {
		newPanel.getScene().getWindow().hide();
	}

	public Drug getDrug() {
		drug = new Drug();
		drug.setPrice(Double.parseDouble(text4.getText()));
		drug.setCeilingPrice(Double.parseDouble(text5.getText()));
		drug.setEnglish(text3.getText());
		drug.setName(text2.getText());
		drug.setCode(text1.getText());
		drug.setHospitalPreparationMark(choice1.getValue());
		drug.setPrescriptionSign(choice2.getValue());
		drug.setApprovalMark(choice3.getValue());
		newPanel.getScene().getWindow().hide();
		return drug;

	}

	public boolean hasNull() {
		if ((choice1.getValue()==null||choice2.getValue()==null||choice3.getValue()==null||choice1.getValue().equals("null")) || (choice2.getValue().equals("null"))
				|| (choice3.getValue().equals("null")) || (text1.getText().equals("null"))
				|| (text2.getText().equals("null")) || (text3.getText().equals("null"))
				|| (text4.getText().equals("null")) || (text5.getText().equals("null")) || (text1.getText().equals(""))
				|| (text2.getText().equals("")) || (text3.getText().equals("")) || (text4.getText().equals(""))
				|| (text5.getText().equals(""))) {
			return true;
		} else
			return false;
	}

	public void alartNull() {
		Alert alert = new Alert(AlertType.WARNING, "请全部填写！", ButtonType.CLOSE);
		alert.show();
	}

	public void initModify(Drug selecetedDrug) {
		text1.setText(selecetedDrug.getCode());
		text2.setText(selecetedDrug.getName());
		text3.setText(selecetedDrug.getEnglish());
		text4.setText(((Double) selecetedDrug.getPrice()).toString());
		text5.setText(((Double) selecetedDrug.getCeilingPrice()).toString());
		choice1.setValue(selecetedDrug.getHospitalPreparationMark());
		choice2.setValue(selecetedDrug.getPrescriptionSign());
		choice3.setValue(selecetedDrug.getApprovalMark());
	}

}
