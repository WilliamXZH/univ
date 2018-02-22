package dao;

import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Scanner;

import org.json.JSONException;
import org.json.JSONObject;

import base.Base;
import base.Disease;
import base.Drug;
import base.MedicalInstitution;
import base.Person;
import base.ServiceFacility;
import base.TreatmentProject;
import list.DiseaseList;
import list.DrugList;
import list.MedicalInstitutionList;
import list.PersonList;
import list.ServiceFacilityList;
import list.TreatmentProjectList;

public class BaseLoader {
	public DiseaseList loadDisease(String FileName) throws IOException, JSONException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		DiseaseList list = new DiseaseList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject Disease = new JSONObject(line);
			Converter con = new Converter();
			Disease d = con.convertToDisease(Disease);
			list.add(d);
		}
		reader.close();
		in.close();
		return list;
	}

	public DrugList loadDrug(String FileName) throws IOException, JSONException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		DrugList list = new DrugList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject Drug = new JSONObject(line);
			Converter con = new Converter();
			list.add(con.convertToDrug(Drug));
		}
		reader.close();
		in.close();
		return list;
	}

	public MedicalInstitutionList loadMedicalInstitution(String FileName) throws IOException, JSONException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		MedicalInstitutionList list = new MedicalInstitutionList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject MedicalInstitution = new JSONObject(line);
			Converter con = new Converter();
			list.add(con.convertToMedicalInstitution(MedicalInstitution));
		}
		reader.close();
		in.close();
		return list;
	}

	public PersonList loadPerson(String FileName) throws IOException, JSONException, ParseException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		PersonList list = new PersonList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject Person = new JSONObject(line);
			Converter con = new Converter();
			list.add(con.convertToPerson(Person));
		}
		reader.close();
		in.close();
		return list;
	}

	public ServiceFacilityList loadServiceFacility(String FileName) throws IOException, JSONException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		ServiceFacilityList list = new ServiceFacilityList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject ServiceFacility = new JSONObject(line);
			Converter con = new Converter();
			list.add(con.convertToServiceFacility(ServiceFacility));
		}
		reader.close();
		in.close();
		return list;
	}

	public TreatmentProjectList loadTreatmentProject(String FileName) throws IOException, JSONException {
		FileReader reader = new FileReader(FileName);
		Scanner in = new Scanner(reader);
		TreatmentProjectList list = new TreatmentProjectList();
		while (in.hasNextLine()) {
			String line = in.nextLine();
			if (line.equals("\n"))
				break;
			JSONObject TreatmentProject = new JSONObject(line);
			Converter con = new Converter();
			list.add(con.convertToTreatmentProject(TreatmentProject));
		}
		reader.close();
		in.close();
		return list;
	}
}
