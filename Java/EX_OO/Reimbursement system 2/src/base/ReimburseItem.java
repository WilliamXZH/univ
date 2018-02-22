package base;

import java.util.ArrayList;

public class ReimburseItem {
	private Person person;
	private ArrayList<Prescription> prescriptions;
	private MedicalInstitution hospital;
 	private double tatolPrice=0;
	private double personalPrice=0;
	private double reimbursedPrice=0;
	public ReimburseItem(){
		prescriptions=new ArrayList<Prescription>();
	}
	public Person getPerson() {
		return person;
	}
	public ArrayList<Prescription> getPrescriptions() {
		return prescriptions;
	}
	public double getTatolPrice() {
		return tatolPrice;
	}
	public double getPersonalPrice() {
		return personalPrice;
	}
	public double getReimbursedPrice() {
		return reimbursedPrice;
	}
	public void setPerson(Person person) {
		this.person = person;
	}
	public void setPrescriptions(ArrayList<Prescription> prescriptions) {
		this.prescriptions = prescriptions;
	}
	public void setTatolPrice(double tatolPrice) {
		this.tatolPrice = tatolPrice;
	}
	public void setPersonalPrice(double personalPrice) {
		this.personalPrice = personalPrice;
	}
	public void setReimbursedPrice(double reimbursedPrice) {
		this.reimbursedPrice = reimbursedPrice;
	}
	public void addPrescription(Prescription prescription) {
		prescriptions.add(prescription);
	}
	/*private void calculatePrice() {
		tatolPrice=0;
		personalPrice=0;
		reimbursedPrice=0;
		if(person==null||prescriptions==null||hospital==null) {
			return;
		}
		for(Prescription pre:prescriptions) {
			double drugPersonalPrice=0;
			String base=pre.getBase();
			tatolPrice+=base.getPrice();
			if(base.getClass().equals("Drug")) {
				Drug drug=(Drug)base;
				if(drug.getPrice()>drug.getCeilingPrice()) {
					drugPersonalPrice+=drug.getPrice()-drug.getCeilingPrice();
					if(drug.getChargeClass().equals("乙")) {
						drugPersonalPrice+=0.5*drug.getCeilingPrice();
					}if(drug.getChargeClass().equals("丙")) {
						drugPersonalPrice+=drug.getCeilingPrice();
					}
				}else {
					if(drug.getChargeClass().equals("乙")) {
						drugPersonalPrice+=0.5*drug.getPrice();
					}if(drug.getChargeClass().equals("丙")) {
						drugPersonalPrice+=drug.getPrice();
					}
				}
				if(!hospitalQualification(drug)) {
					drugPersonalPrice=drug.getPrice();
				}
				personalPrice+=drugPersonalPrice;
				reimbursedPrice+=base.getPrice()-drugPersonalPrice;
			}
			if(base.getClass().equals("TreatmentProject")) {
				TreatmentProject drug=(TreatmentProject)base;
				if(drug.getChargeClass().equals("乙")) {
					drugPersonalPrice+=0.5*drug.getPrice();
				}if(drug.getChargeClass().equals("丙")) {
					drugPersonalPrice+=drug.getPrice();
				}
				if(!hospitalQualification(drug)) {
					drugPersonalPrice=drug.getPrice();
				}
				personalPrice+=drugPersonalPrice;
				reimbursedPrice+=base.getPrice()-drugPersonalPrice;
			} 
			if(base.getClass().equals("ServiceFacility")) {
				reimbursedPrice+=base.getPrice();
			} 
		}
	}
	private boolean hospitalQualification(Base base){
		int hospitalLevel = 0,baseLevel = 0;
		if(hospital.getLevle().equals("一级医院")) {
			hospitalLevel=1;
		}
		if(hospital.getLevle().equals("二级医院")) {
			hospitalLevel=2;
		}
		if(hospital.getLevle().equals("三级医院")) {
			hospitalLevel=3;
		}
		if(hospital.getLevle().equals("社区医院")) {
			hospitalLevel=4;
		}
		if(base.getClass().equals("Drug")) {
			Drug drug=(Drug)base;
			if(drug.getHospitalPreparationMark().equals("一级医院")) {
				baseLevel=1;
			}
			if(drug.getHospitalPreparationMark().equals("二级医院")) {
				baseLevel=2;
			}
			if(drug.getHospitalPreparationMark().equals("三级医院")) {
				baseLevel=3;
			}
			if(drug.getHospitalPreparationMark().equals("社区医院")) {
				baseLevel=4;
			}
		}
		if(base.getClass().equals("TreatmentProject")) {
			TreatmentProject drug=(TreatmentProject)base;
			if(drug.getHospitalLevel().equals("一级医院")) {
				baseLevel=1;
			}
			if(drug.getHospitalLevel().equals("二级医院")) {
				baseLevel=2;
			}
			if(drug.getHospitalLevel().equals("三级医院")) {
				baseLevel=3;
			}
			if(drug.getHospitalLevel().equals("社区医院")) {
				baseLevel=4;
			}
		}
		if(baseLevel>hospitalLevel) {
			return false;
		}
		else {
			return true;
		}*/
	public MedicalInstitution getHospital() {
		return hospital;
	}
	public void setHospital(MedicalInstitution hospital) {
		this.hospital = hospital;
	}
	}
