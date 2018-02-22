package dao;

import java.text.ParseException;
import java.util.Date;

import org.json.JSONException;
import org.json.JSONObject;

import base.Base;
import base.Disease;
import base.Drug;
import base.MedicalInstitution;
import base.Person;
import base.ServiceFacility;
import base.TreatmentProject;
import tool.DateFormatter;

public class Converter {
	
	public Drug convertToDrug(JSONObject j) throws JSONException {
		Drug drug = new Drug(j.getString("code"), j.getString("name"), j.getString("english"),
				j.getString("chargeClass"), j.getString("prescriptionSign"), j.getString("feeLevel"),
				j.getString("doseUnit"), j.getDouble("ceilingPrice"), j.getDouble("price"),
				j.getString("hospitalPreparationMark"), j.getString("frequency"), j.getString("factory"),
				j.getString("notes"), j.getString("usage"), j.getString("units"), j.getString("specification"),
				j.getString("place"), j.getString("codeOfNationalDirectory"), j.getString("nationalDrugCertificate"),
				j.getString("tradeName"), j.getString("limitRange"), j.getString("approvalMark"),
				j.getString("limitDays"));
		return drug;
	}

	public Disease convertToDisease(JSONObject j) throws JSONException {
		Disease disease = new Disease(j.getString("code"), j.getString("name"), j.getString("cetegory"),
				j.getString("reimbursementMark"), j.getString("notes"));
		return disease;
	}

	public MedicalInstitution convertToMedicalInstitution(JSONObject j) throws JSONException {
		MedicalInstitution disease = new MedicalInstitution(j.getString("name"), j.getString("code"),
				j.getString("levle"), j.getString("category"), j.getString("postCode"),
				j.getString("legalRepresentativeName"), j.getString("legalRepresentativePhone"),
				j.getString("contactName"), j.getString("contactNumber"), j.getString("address"), j.getString("notes"));
		return disease;
	}

	public Person convertToPerson(JSONObject j) throws JSONException, ParseException {
		Date birthday = DateFormatter.stringToDay(j.getString("birthday"));
		Date dischargeDate = DateFormatter.stringToDay(j.getString("dischargeDate"));
		Person disease = new Person(j.getString("name"), j.getString("ID"), j.getString("gender"), birthday,
				j.getString("medicalCategory"), j.getString("unitNumber"), j.getString("unitName"),
				j.getInt("hospitalizationTimes"), dischargeDate, j.getString("dischargeDiagnosis"),
				j.getDouble("reimbursementSumOfYear"), j.getDouble("personalExpenseSumOfYear"),
				j.getDouble("totalExpenseOfYear"),j.getString("hospitalCode"));
		return disease;
	}

	public ServiceFacility convertToServiceFacility(JSONObject j) throws JSONException {
		ServiceFacility drug = new ServiceFacility(j.getString("code"), j.getString("name"), j.getDouble("price"),
				j.getString("chargeClass"), j.getString("notes"), j.getString("limitRange"));
		return drug;
	}

	public TreatmentProject convertToTreatmentProject(JSONObject j) throws JSONException {
		TreatmentProject disease = new TreatmentProject(j.getString("code"), j.getString("name"), j.getDouble("price"),
				j.getString("chargeClass"), j.getString("chargeLevel"), j.getString("hospitalLevel"),
				j.getString("approvalMark"), j.getString("unit"), j.getString("factory"), j.getString("notes"),
				j.getString("limitRange"));
		return disease;
	}
}
