
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.ResourceBundle;

import org.json.JSONException;
import org.json.JSONObject;

import base.Disease;
import base.Drug;
import base.MedicalInstitution;
import base.Person;
import base.ServiceFacility;
import base.TreatmentProject;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;
import list.DiseaseList;
import list.DrugList;
import list.MedicalInstitutionList;
import list.PersonList;
import list.ServiceFacilityList;
import list.TreatmentProjectList;
import tool.AlertBox;

public class IndexController implements Initializable {
	@FXML
	private Button newButton;
	@FXML
	private Button addButton,addButton1;
	@FXML
	private Button modifyButton,modifyButton1;
	@FXML
	private ListView<String> choiceList;
	@FXML
	private AnchorPane drugPanel;
	@FXML
	private TableColumn codeCol,personCol1,personCol2,personCol3,personCol4,personCol5;
	@FXML
	private TableColumn nameCol;
	@FXML
	private TableColumn englishCol;
	@FXML
	private TableColumn signCol;
	@FXML
	private TableView drugTable;
	@FXML
	private TableView personTable;
	@FXML
	private Label titleLabel;
	private int state=1;
	public int getState() {
		return state;
	}
	public void fillList() {
		ObservableList<String> strList = FXCollections.observableArrayList("ҩƷ��Ϣά��", "������Ŀ��Ϣά��", "������ʩ��Ŀά��", "������Ϣά��",
				"����ҽ�ƻ�����Ϣά��", "ҽ�ƴ����������ά��");
		choiceList.setItems(strList);
	}
	
	public void drugTableClicked(MouseEvent e) throws JSONException {
		Stage stage=new Stage();
		VBox Pane=new VBox();
		Pane.setSpacing(2);
		Scene scene=new Scene(Pane);
		if(e.getClickCount()==2) {
				Object drug=drugTable.getSelectionModel().getSelectedItem();
				JSONObject jDrug=new JSONObject(drug);
				Iterator<String> iterator1=jDrug.keys();
				while(iterator1.hasNext()) {
					int i=0;
					String name=iterator1.next();
					String value=jDrug.getString(name);
					Label label=new Label(name+":"+value);
					label.fontProperty();
					Pane.getChildren().add(label);
					i++;
			}
		}
	} 
	
	private void initTable(DrugList drugList) {
		ObservableList<Drug> data = FXCollections.observableArrayList();
		for (Drug drug : drugList) {
			data.add(drug);
		}
		codeCol.setCellValueFactory(new PropertyValueFactory<>("code"));
		nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
		englishCol.setCellValueFactory(new PropertyValueFactory<>("english"));
		signCol.setCellValueFactory(new PropertyValueFactory<>("prescriptionSign"));
		drugTable.setItems(data);

	}

	public void drawMedicallInstitutionPanel(MedicalInstitutionList mlist) {
		titleLabel.setText("����ҽ�ƻ�����Ϣά��");
		state=5;
		ObservableList<MedicalInstitution> data = FXCollections.observableArrayList();
		for (MedicalInstitution drug : mlist) {
			data.add(drug);
		}
		codeCol.setCellValueFactory(new PropertyValueFactory<>("code"));
		nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
		englishCol.setCellValueFactory(new PropertyValueFactory<>("english"));
		signCol.setCellValueFactory(new PropertyValueFactory<>("prescriptionSign"));
		drugTable.setItems(data);
	}

	public void drawTreatmentProjectPanel(TreatmentProjectList tlist) {
		titleLabel.setText("������Ŀ��Ϣά��");
		state=2;
		ObservableList<TreatmentProject> data = FXCollections.observableArrayList();
		for (TreatmentProject TreatmentProject : tlist) {
			data.add(TreatmentProject);
		}
		codeCol.setCellValueFactory(new PropertyValueFactory<>("code"));
		nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
		englishCol.setCellValueFactory(new PropertyValueFactory<>("english"));
		signCol.setCellValueFactory(new PropertyValueFactory<>("prescriptionSign"));
		drugTable.setItems(data);
	}

	public void drawServiceFacilityPanel(ServiceFacilityList slist) {
		titleLabel.setText("������ʩ��Ŀά��");
		state=3;
		ObservableList<ServiceFacility> data = FXCollections.observableArrayList();
		for (ServiceFacility ServiceFacility : slist) {
			data.add(ServiceFacility);
		}
		codeCol.setCellValueFactory(new PropertyValueFactory<>("code"));
		nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
		englishCol.setCellValueFactory(new PropertyValueFactory<>("english"));
		signCol.setCellValueFactory(new PropertyValueFactory<>("prescriptionSign"));
		drugTable.setItems(data);
	}

	public void drawDiseasePanel(DiseaseList dlist) {
		titleLabel.setText("������Ϣά��");
		state=4;
		ObservableList<Disease> data = FXCollections.observableArrayList();
		for (Disease drug : dlist) {
			data.add(drug);
		}
		codeCol.setCellValueFactory(new PropertyValueFactory<>("code"));
		nameCol.setCellValueFactory(new PropertyValueFactory<>("name"));
		englishCol.setCellValueFactory(new PropertyValueFactory<>("english"));
		signCol.setCellValueFactory(new PropertyValueFactory<>("prescriptionSign"));
		drugTable.setItems(data);
	}

	public void drawDrugPanel(DrugList drugList) {
		titleLabel.setText("ҩƷ��Ϣά��");
		state=1;
		ObservableList<Drug> data = FXCollections.observableArrayList();
		for (Drug drug : drugList) {
			data.add(drug);
		}
		initTable(drugList);
	}

	public void addClicked(ActionEvent actionEvent) {

	}

	public void modifyClicked(ActionEvent enent) {

	}

	public void searchClicked(ActionEvent enent) {

	}

	@Override
	public void initialize(URL url, ResourceBundle rb) {
		drugTable.setPlaceholder(new Label(""));
		personTable.setPlaceholder(new Label(""));
		fillList();
	}

	public Drug getSelectedDrug() {
		Drug selectedDrug = (Drug) drugTable.getSelectionModel().getSelectedItem();
		return selectedDrug;
	}

	public void drawNonePanel() {
		new AlertBox("�����ڴ�","�˴��������ڿ�����").alert();
	}

	public void initPersonTable(PersonList pList) {
		ObservableList<Person> data = FXCollections.observableArrayList();
		for (Person p : pList) {
			data.add(p);
		}
		personCol1.setCellValueFactory(new PropertyValueFactory<>("ID"));
		personCol2.setCellValueFactory(new PropertyValueFactory<>("unitName"));
		personCol3.setCellValueFactory(new PropertyValueFactory<>("name"));
		personCol4.setCellValueFactory(new PropertyValueFactory<>("gender"));
		personCol5.setCellValueFactory(new PropertyValueFactory<>("birthday"));
		personTable.setItems(data);

	}

	public Person getSelectedPerson() {
		Person selectedPerson = (Person) personTable.getSelectionModel().getSelectedItem();
		return selectedPerson;
	}

}
