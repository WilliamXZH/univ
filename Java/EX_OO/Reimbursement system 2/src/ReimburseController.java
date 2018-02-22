
import java.net.URL;
import java.util.Date;
import java.util.ResourceBundle;

import base.Base;
import base.Drug;
import base.Person;
import base.Prescription;
import base.ReimburseItem;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.layout.GridPane;
import list.PersonList;
import tool.AlertBox;
import tool.DateFormatter;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;

public class ReimburseController implements Initializable{
	@FXML
	private Button next1,back1,back2;
	private static double cellHeight =22;
	@FXML
	private Button next2;
	@FXML
	private TextField IDText,prescriptionName,text1,text2,text3,
						prescriptionPrice,prescriptionAmount,admissionNumberText;
	@FXML
	private GridPane panel1, panel2, panel3;
	@FXML
	private Button confirmButton,addPreButton;
	@FXML
	private ListView<String> searchList;
	@FXML
	private Label l1,l2,l3,l4,l5,l6,l7,l8,l9;
	@FXML
	private ComboBox<String> comboBox;
	@FXML
	private TableColumn preCol1,preCol2,preCol3,preCol4,preCol5;
	@FXML
	private TableView preTable;
	private ObservableList<Prescription> list; 
	private Person foundPerson;
	public void onDownPressed(KeyEvent e) {
		
	}
	public void addPre(ActionEvent e) {
			
	}
	public void fillLabel(Person p) {
		foundPerson=p;
		l1.setText("  姓名："+p.getName());
		l2.setText("性别："+p.getGender());
		l3.setText("  证件号："+p.getID());
		l4.setText("出生日期："+p.getGender());
		l5.setText("  门诊编号："+p.getHospitalCode());
		l6.setText("报销日期："+DateFormatter.dayToString(new Date()));
	}
	public boolean hasNull2() {
		if ((comboBox.getValue()==null || (comboBox.getValue().equals("null"))
				|| (prescriptionName.getText().equals(""))
				|| (prescriptionPrice.getText().equals("")) 
				|| (prescriptionAmount.getText().equals(""))))  {
			return true;
		} else
			return false;
	}
	public boolean hasNull1() {
		if (IDText.getText().equals("")
				|| (admissionNumberText.getText().equals("")) 
				|| (text1.getText().equals(""))
				|| (text2.getText().equals(""))
				|| (text3.getText().equals(""))
				 ) {
			return true;
		} else
			return false;
	}
	public void alertNull() {
		Alert alert = new Alert(AlertType.WARNING, "请全部填写！", ButtonType.CLOSE);
		alert.show();
	}
	public void clear() {
		prescriptionName.setText("");
		prescriptionPrice.setText("");
		prescriptionAmount.setText("");
		comboBox.setValue(null);
	}
	public Prescription getPre() {
		Prescription pre=new Prescription();
		pre.setAdmissionNumber(admissionNumberText.getText());
		pre.setAmount(Integer.parseInt(prescriptionAmount.getText()));
		pre.setPreClass(comboBox.getValue());
		pre.setBase(prescriptionName.getText());
		pre.setCode(((Integer)(preTable.getItems().size()+1)).toString());
		pre.setPrice(Double.parseDouble(prescriptionPrice.getText()));
		return pre;
	}
	public void onDoubleClicked(MouseEvent e,Person p) {
		if(e.getClickCount()==2) {

			String selected=searchList.getSelectionModel().getSelectedItem();
			IDText.setText(selected);
			searchList.setVisible(false);
			IDText.requestFocus();
			fillLabel(p);
			foundPerson=p;
		}
	}
	public void onUpPressed(KeyEvent e) {
		if(e.getCode()==KeyCode.UP) {
			if(searchList.getSelectionModel().getSelectedIndex()==0) {
			IDText.requestFocus();
			}
		}
		if(e.getCode()==KeyCode.ENTER) {
			searchList.setVisible(false);
			String selected=searchList.getSelectionModel().getSelectedItem();
			if(selected==null) {
				IDText.setText(searchList.getItems().get(0));
			}else {
				IDText.setText(selected);
			}
			IDText.requestFocus();
		}
	}
	public void next1(ActionEvent actionEvent) {
		if(foundPerson==null) {
			new AlertBox("警告","请填写正确的ID或姓名").alert();
		}else {
			if(hasNull1())
				alertNull();
			else {
				panel1.setVisible(false);
				panel2.setVisible(true);
				panel3.setVisible(false);
			}
		}
	}
	public void back1(ActionEvent actionEvent) {
		panel1.setVisible(true);
		panel2.setVisible(false);
		panel3.setVisible(false);
	}
	public void back2(ActionEvent actionEvent) {
		panel1.setVisible(false);
		panel2.setVisible(true);
		panel3.setVisible(false);
	}
	public void next2() {	
			panel1.setVisible(false);
			panel2.setVisible(false);
			panel3.setVisible(true);
	}
	
	public void drawIDSearchListView(PersonList showList1, PersonList showList2) {
		ObservableList<String> data = FXCollections.observableArrayList();
			searchList.setPrefHeight((showList1.size()+showList2.size())*cellHeight);
			for(Person p:showList1) {
				data.add(p.getID());
			}
			for(Person p:showList2) {
				data.add(p.getName());
			}
			searchList.setItems(data);	
	}
	public void drawInformationTable(Person foundPerson) {
		
	}
	public ReimburseItem getReimburseItem() {
		ReimburseItem item = new ReimburseItem();
		item.setPerson(foundPerson);
		return item;
	}
	@Override
	public void initialize(URL location, ResourceBundle resources) {
		comboBox.setItems(FXCollections.observableArrayList("甲","乙","丙"));
		preTable.setPlaceholder(new Label(""));
		list=FXCollections.observableArrayList();
		preCol1.setCellValueFactory(new PropertyValueFactory<>("code"));
		preCol2.setCellValueFactory(new PropertyValueFactory<>("base"));
		preCol3.setCellValueFactory(new PropertyValueFactory<>("preClass"));
		preCol4.setCellValueFactory(new PropertyValueFactory<>("price"));
		preCol5.setCellValueFactory(new PropertyValueFactory<>("amount"));
	}
	public  ObservableList<Prescription> getList(){
		return list;
	}
	public void initLabel() {
		foundPerson=null;
		l1.setText("  姓名：");
		l2.setText("性别：");
		l3.setText("  证件号：");
		l4.setText("出生日期：");
		l5.setText("  门诊编号：");
		l6.setText("报销日期：");
	}
	public void showPrice(double[] prices) {
		l7.setText("费用总额："+prices[0]);
		l8.setText("报销金额："+prices[1]);
		l9.setText("自费金额："+prices[2]);
	}
}
