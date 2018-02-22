import java.io.IOException;
import java.text.ParseException;
import org.json.JSONException;

import base.Base;
import base.Drug;
import base.Person;
import base.Prescription;
import base.ReimburseItem;
import base.ServiceFacility;
import base.TreatmentProject;
import dao.BaseLoader;
import dao.BaseWriter;
import javafx.application.Application;
import javafx.beans.value.ObservableValue;
import javafx.collections.ObservableList;
import javafx.event.EventHandler;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;
import list.DiseaseList;
import list.DrugList;
import list.MedicalInstitutionList;
import list.PersonList;
import list.ReimburseList;
import list.ServiceFacilityList;
import list.TreatmentProjectList;
import tool.AlertBox;

public class Main extends Application {
	private static Stage primaryStage;
	private static Stage stage;
	private DiseaseList dList;
	private MedicalInstitutionList mList;
	private PersonList pList;
	private static DrugList drugList;
	private ServiceFacilityList sList;
	private TreatmentProjectList tList;
	private ReimburseList rList;
	private IndexController indexController;
	private NewDrugController newDrugController;
	private ReimburseController reimburseController;
	private NewPersonController newPersonController;
	private Person foundPerson;

	public static void main(String[] args) {
		launch(args);
	}

	@Override
	public void start(Stage primaryStage) throws Exception {
		initDao();
		FXMLLoader loader = new FXMLLoader();
		try {
			loader.setLocation(Main.class.getResource("index.fxml"));
			Parent root = loader.load();
			indexController = loader.getController();
			indexController.drawDrugPanel(drugList);
			indexController.initPersonTable(pList);
			choiceListAction(root);
			newButtonAction(root);
			addButtonAction(root);
			modifyButtonAction(root);
			searchButtonAction(root);
			delButtonAction(root);
			searchTextAction(root);
			primaryStage.setScene(new Scene(root));
			primaryStage.show();
			primaryStage.setOnCloseRequest(new EventHandler<WindowEvent>() {
				@Override
				public void handle(WindowEvent event) {
					saveDataToFile();
				}
			});

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	private void choiceListAction(Parent root) {
		ListView<String> choiceList = (ListView<String>) root.lookup("#choiceList");
		choiceList.getSelectionModel().selectedItemProperty()
				.addListener((ObservableValue<? extends String> observable, String oldValue, String newValue) -> {
					if (newValue.equals("ҩƷ��Ϣά��")) {
						indexController.drawDrugPanel(drugList);
					} else if (newValue.equals("������Ŀ��Ϣά��")) {
						indexController.drawServiceFacilityPanel(sList);
					} else if ((newValue.equals("������ʩ��Ŀά��"))) {
						indexController.drawTreatmentProjectPanel(tList);
					} else if ((newValue.equals("������Ϣά��"))) {
						indexController.drawMedicallInstitutionPanel(mList);
					} else if ((newValue.equals("����ҽ�ƻ�����Ϣά��"))) {
						indexController.drawDiseasePanel(dList);
					} else if ((newValue.equals("ҽ�ƴ����������ά��"))) {
						indexController.drawNonePanel();
					}
				});
	}

	private void IDTextAction(Parent root) {
		TextField IDText = (TextField) root.lookup("#IDText");
		Button confirmButton = (Button) root.lookup("#confirmButton");
		ListView<String> searchListView = (ListView<String>) root.lookup("#searchList");
		searchListView.setVisible(false);
		IDText.setOnKeyReleased(e -> {
			String search = IDText.getText();
			PersonList searchIDList = new PersonList();
			PersonList searchNameList = new PersonList();
			for (Person d : pList) {
				if (d.getID().startsWith(search)) {
					searchIDList.add(d);
				}
				if (d.getName().startsWith(search)) {
					searchNameList.add(d);
				}
				searchListView.setOnMouseClicked(e1->{
					searchListView.requestFocus();
					int selIndex=searchListView.getSelectionModel().getSelectedIndex();
					for(Person person:searchNameList) {
						searchIDList.add(person);
					}
					foundPerson = searchIDList.get(selIndex);
					reimburseController.onDoubleClicked(e1,foundPerson);
				});
				// �����������ͱ����ȵ��������ʵ�����в�����
				if (searchIDList.size() == 1 && searchNameList.size() == 0) {
					reimburseController.drawIDSearchListView(searchIDList, searchNameList);
					foundPerson = searchIDList.get(0);
					if (foundPerson.getID().equals(search)) {
						reimburseController.fillLabel(foundPerson);
						searchListView.setVisible(false);
					}
				} else if (searchIDList.size() == 0 && searchNameList.size() == 1) {
					reimburseController.drawIDSearchListView(searchIDList, searchNameList);
					foundPerson = searchNameList.get(0);
					if (foundPerson.getName().equals(search)) {
						reimburseController.fillLabel(foundPerson);
						searchListView.setVisible(false);
					} else {
					}
				} else {
					reimburseController.initLabel();
					searchListView.setVisible(true);
					reimburseController.drawIDSearchListView(searchIDList, searchNameList);
				}
				if (search.equals("")) {
					searchListView.setVisible(false);
				}
			}
			confirmButton.setOnAction(e1 -> {
				if (searchIDList.size() != 0 || searchNameList.size() != 0) {
					reimburseController.fillLabel(foundPerson);
				}
			});
			
			IDText.setOnKeyPressed(new EventHandler<KeyEvent>() {
				@Override
				public void handle(KeyEvent event) {
					if (event.getCode() == KeyCode.ENTER) {
						if (searchIDList.size() != 0 || searchNameList.size() != 0) {
							reimburseController.drawInformationTable(foundPerson);
						}
					}
					if(e.getCode()==KeyCode.DOWN) {
						searchListView.requestFocus();
					}
				}
			});
		});
	}

	private void searchTextAction(Parent root) {
		TextField searchText = (TextField) root.lookup("#searchText");
		searchText.setOnKeyReleased(e -> {
			String search = searchText.getText();
			DrugList searchList = new DrugList();
			for (Drug d : drugList) {
				boolean con1 = d.getCode().indexOf(search) != -1;
				boolean con2 = d.getName().indexOf(search) != -1;
				boolean con3 = d.getEnglish().indexOf(search) != -1;
				if (con1 || con2 || con3) {
					searchList.add(d);
				}
				indexController.drawDrugPanel(searchList);
			}
		});
		TextField searchText1 = (TextField) root.lookup("#searchText1");
		searchText1.setOnKeyReleased(e -> {
			String search = searchText1.getText();
			PersonList searchList = new PersonList();
			for (Person p : pList) {
				boolean con1 = p.getID().indexOf(search) != -1;
				boolean con2 = p.getName().indexOf(search) != -1;
				if (con1 || con2) {
					searchList.add(p);
				}
				indexController.initPersonTable(searchList);
			}
		});
	}

	private void delButtonAction(Parent root) {
		Button delButton = (Button) root.lookup("#delButton");
		delButton.setOnAction(e -> {
			Drug selecetedDrug = indexController.getSelectedDrug();
			if (selecetedDrug == null) {
				AlertBox alert = new AlertBox("����", "��ѡ��Ҫɾ����ҩƷ��");
				alert.alert();
			} else {
				AlertBox alertBox = new AlertBox("ȷ��ɾ��", "ȷ��Ҫɾ����");
				if (alertBox.isYes()) {
					drugList.delDrug(selecetedDrug);
					indexController.drawDrugPanel(drugList);
				}
			}

		});
	}

	private void searchButtonAction(Parent root) {
		Button searchButton = (Button) root.lookup("#searchButton");
		searchButton.setOnAction(e -> {

		});
	}

	private void modifyButtonAction(Parent root) {
		Button modifyButton = (Button) root.lookup("#modifyButton");
		modifyButton.setOnAction(e -> {
			Drug selecetedDrug = indexController.getSelectedDrug();
			if (selecetedDrug == null) {
				AlertBox alert = new AlertBox("����", "��ѡ��Ҫ�޸ĵ�ҩƷ��");
				alert.alert();
			} else {
				showModifyDrug(selecetedDrug);
			}
		});
		Button modifyButton1 = (Button) root.lookup("#modifyButton1");
		modifyButton1.setOnAction(e -> {
			Person selecetedPerson = indexController.getSelectedPerson();
			if (selecetedPerson == null) {
				AlertBox alert = new AlertBox("����", "��ѡ��Ҫ�޸ĵ���Ա��Ϣ��");
				alert.alert();
			} else {
				showModifyPerson(selecetedPerson);
			}
		});
	}

	private void showModifyPerson(Person selecetedPerson) {
		FXMLLoader loader = new FXMLLoader();
		try {
			Stage stage = new Stage();
			loader.setLocation(Main.class.getResource("newPerson.fxml"));
			Parent root = loader.load();
			newPersonController = loader.getController();
			stage.setScene(new Scene(root));
			stage.setTitle("�޸���Ա��Ϣ��");
			stage.show();
			newPersonController.initModify(selecetedPerson);
			Button okButton = (Button) root.lookup("#personOkButton");
			okButton.setOnAction(e -> {
				if (newPersonController.hasNull()) {
					newPersonController.alartNull();
				} else {
					pList.replacePerson(newPersonController.getPerson(), selecetedPerson);
					stage.hide();
					indexController.initPersonTable(pList);
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void addButtonAction(Parent root) {
		Button addButton = (Button) root.lookup("#addButton");
		addButton.setOnAction(e -> {
			showNewDrug();
		});
		Button addButton1 = (Button) root.lookup("#addButton1");
		addButton1.setOnAction(e -> {
			showNewPerson();
		});
	}

	private void showNewPerson() {
		FXMLLoader loader = new FXMLLoader();
		try {
			Stage stage = new Stage();
			loader.setLocation(Main.class.getResource("newPerson.fxml"));
			Parent root = loader.load();
			newPersonController = loader.getController();
			stage.setScene(new Scene(root));
			stage.setTitle("��Ӹ�����Ϣ��");
			stage.show();
			Button modifyButton = (Button) root.lookup("#personOkButton");
			modifyButton.setOnAction(e -> {
				if (newPersonController.hasNull()) {
					newPersonController.alartNull();
				} else {
					Person drug = newPersonController.getPerson();
					pList.add(drug);
					stage.hide();
					indexController.initPersonTable(pList);
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void newButtonAction(Parent root) {
		Button addButton = (Button) root.lookup("#newButton");
		addButton.setOnAction(e -> {
			showReimburse();
		});
	}

	private void showModifyDrug(Drug selecetedDrug) {
		FXMLLoader loader = new FXMLLoader();
		try {
			Stage stage = new Stage();
			loader.setLocation(Main.class.getResource("newDrug.fxml"));
			Parent root = loader.load();
			newDrugController = loader.getController();
			stage.setScene(new Scene(root));
			stage.setTitle("�޸�ҩƷ��Ϣ��");
			stage.show();
			newDrugController.initModify(selecetedDrug);
			Button modifyButton = (Button) root.lookup("#okButton");
			modifyButton.setOnAction(e -> {
				if (newDrugController.hasNull()) {
					newDrugController.alartNull();
				} else {
					drugList.replaceDrug(newDrugController.getDrug(), selecetedDrug);
					stage.hide();
					indexController.drawDrugPanel(drugList);
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void showNewDrug() {
		FXMLLoader loader = new FXMLLoader();
		try {
			Stage stage = new Stage();
			loader.setLocation(Main.class.getResource("newDrug.fxml"));
			Parent root = loader.load();
			newDrugController = loader.getController();
			stage.setScene(new Scene(root));
			stage.setTitle("���ҩƷ��Ϣ��");
			stage.show();
			Button okButton = (Button) root.lookup("#okButton");
			okButton.setOnAction(e -> {
				if (newDrugController.hasNull()) {
					newDrugController.alartNull();
				} else {
					Drug drug = newDrugController.getDrug();
					drugList.add(drug);
					stage.hide();
					indexController.drawDrugPanel(drugList);
				}
			});
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void showReimburse() {
		FXMLLoader loader = new FXMLLoader();
		try {
			stage = new Stage();
			loader.setLocation(Main.class.getResource("reimburse.fxml"));
			Parent root = loader.load();
			reimburseController = loader.getController();
			stage.setScene(new Scene(root));
			IDTextAction(root);
			sumButtonAction(root);
			addPreButtonAction(root);
			delPreButtonAction(root);
			stage.show();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	private void sumButtonAction(Parent root) {
		 Button sumButton=(Button)root.lookup("#next2");
		 sumButton.setOnAction(e->{
			 ObservableList<Prescription> data=reimburseController.getList();
			 if(data.size()==0) {
				new AlertBox("����","����Ӵ�����").alert();
			}
			else {
				 reimburseController.next2();
				 ReimburseItem reimburseItem = new ReimburseItem();
				 for(int i=0;i<data.size();i++) {
					 reimburseItem.addPrescription(data.get(i));
				 }
				 double[] prices= calculatePrice(reimburseItem);
				 reimburseController.showPrice(prices);
			 }
		 });
	}
	
	private double[] calculatePrice(ReimburseItem r) {
		double totalPrice=0;
		double personalPrice=0;
		double reimbursedPrice=0;
		for(Prescription pre:r.getPrescriptions()) {
			double drugPersonalPrice=0;
			String name=pre.getBase();
			Drug drug = drugList.getDrug(name);
			ServiceFacility sf =sList.getServiceFacility(name);
			TreatmentProject tp=tList.getTreatmentProject(name);
			if(drug!=null) {
				totalPrice+=drug.getPrice();
				if(drug.getPrice()>drug.getCeilingPrice()) {
					drugPersonalPrice+=drug.getPrice()-drug.getCeilingPrice();
					if(drug.getChargeClass().equals("��")) {
						drugPersonalPrice+=0.5*drug.getCeilingPrice();
					}if(drug.getChargeClass().equals("��")) {
						drugPersonalPrice+=drug.getCeilingPrice();
					}
				}else {
					if(drug.getChargeClass().equals("��")) {
						drugPersonalPrice+=0.5*drug.getPrice();
					}if(drug.getChargeClass().equals("��")) {
						drugPersonalPrice+=drug.getPrice();
					}
				}
				if(!hospitalQualification(drug, r)) {
					drugPersonalPrice=drug.getPrice();
				}
				personalPrice+=drugPersonalPrice;
				reimbursedPrice+=drug.getPrice()-drugPersonalPrice;
			}else if(tp!=null) {
				totalPrice+=tp.getPrice();
				if(tp.getChargeClass().equals("��")) {
					drugPersonalPrice+=0.5*tp.getPrice();
				}if(tp.getChargeClass().equals("��")) {
					drugPersonalPrice+=tp.getPrice();
				}
				if(!hospitalQualification(tp, r)) {
					drugPersonalPrice=tp.getPrice();
				}
				personalPrice+=drugPersonalPrice;
				reimbursedPrice+=tp.getPrice()-drugPersonalPrice;
			} else if(sf!=null) {
				totalPrice+=sf.getPrice();
				reimbursedPrice+=sf.getPrice();
			} 
		}
			double[] array= {totalPrice,personalPrice,reimbursedPrice};
		return array;
	}
	private boolean hospitalQualification(Base base,ReimburseItem r){
		int hospitalLevel = 0,baseLevel = 0;
		
			if(r.getHospital().getLevle().equals("һ��ҽԺ")) {
				hospitalLevel=1;
			}
			if(r.getHospital().getLevle().equals("����ҽԺ")) {
				hospitalLevel=2;
			}
			if(r.getHospital().getLevle().equals("����ҽԺ")) {
				hospitalLevel=3;
			}
			if(r.getHospital().getLevle().equals("����ҽԺ")) {
				hospitalLevel=4;
			}
		
		if(base.getClass().equals("Drug")) {
			Drug drug=(Drug)base;
			if(drug.getHospitalPreparationMark().equals("һ��ҽԺ")) {
				baseLevel=1;
			}
			if(drug.getHospitalPreparationMark().equals("����ҽԺ")) {
				baseLevel=2;
			}
			if(drug.getHospitalPreparationMark().equals("����ҽԺ")) {
				baseLevel=3;
			}
			if(drug.getHospitalPreparationMark().equals("����ҽԺ")) {
				baseLevel=4;
			}
		}
		if(base.getClass().equals("TreatmentProject")) {
			TreatmentProject drug=(TreatmentProject)base;
			if(drug.getHospitalLevel().equals("һ��ҽԺ")) {
				baseLevel=1;
			}
			if(drug.getHospitalLevel().equals("����ҽԺ")) {
				baseLevel=2;
			}
			if(drug.getHospitalLevel().equals("����ҽԺ")) {
				baseLevel=3;
			}
			if(drug.getHospitalLevel().equals("����ҽԺ")) {
				baseLevel=4;
			}
		}
		if(baseLevel>hospitalLevel) {
			return false;
		}
		else {
			return true;
		}
	}
	private void delPreButtonAction(Parent root) {
		Button delButton = (Button) root.lookup("#delPreButton");
		TableView preTable=(TableView)root.lookup("#preTable");
		delButton.setOnAction(e -> {
			ObservableList<Prescription> list=reimburseController.getList();
			Prescription prescription=(Prescription)preTable.getSelectionModel().getSelectedItem();
			if (prescription == null) {
				AlertBox alert = new AlertBox("����", "��ѡ��Ҫɾ���Ĵ�����");
				alert.alert();
			} else {
				AlertBox alertBox = new AlertBox("ȷ��ɾ��", "ȷ��Ҫɾ����");
				if (alertBox.isYes()) {
					list.remove(prescription);
					preTable.setItems(list);
				}
			}

		});
	}

	private void addPreButtonAction(Parent root) {
		Button addPre =(Button)root.lookup("#addPreButton");
		TableView preTable=(TableView)root.lookup("#preTable");
		addPre.setOnAction(e ->{
			if(reimburseController.hasNull2())
				reimburseController.alertNull();
			else {
				Prescription pre= reimburseController.getPre();
				ObservableList<Prescription> list=reimburseController.getList();
				list.add(pre);
				preTable.setItems(list);
				reimburseController.clear();
			}
		});
	}

	private void saveDataToFile() {
		BaseWriter writer = new BaseWriter();
		writer.writeDrug(drugList, "Drug.data");
		writer.writeDisease(dList, "Disease.data");
		writer.writeMedicalInstitution(mList, "MedicalInstitution.data");
		writer.writePerson(pList, "Person.data");
		writer.writeServiceFacility(sList, "ServiceFacility.data");
		writer.writeTreatmentProject(tList, "TreatmentProject.data");
	}

	private void initDao() throws IOException, JSONException, ParseException {
		BaseLoader loader = new BaseLoader();
		drugList = loader.loadDrug("Drug.data");
		dList = loader.loadDisease("Disease.data");
		mList = loader.loadMedicalInstitution("MedicalInstitution.data");
		pList = loader.loadPerson("Person.data");
		sList = loader.loadServiceFacility("ServiceFacility.data");
		tList = loader.loadTreatmentProject("TreatmentProject.data");
	}
}
