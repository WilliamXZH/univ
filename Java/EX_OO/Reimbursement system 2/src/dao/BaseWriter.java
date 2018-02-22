package dao;

import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

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

public class BaseWriter {
	public void write(Base base, String fileName) throws IOException {
		FileWriter writer = new FileWriter(fileName, false);
		writer.write(base.toString() + "\n");
		writer.close();
	}

	public void writeBase(ArrayList<Base> bases, String fileName) throws IOException {
		FileWriter writer = new FileWriter(fileName, false);
		for (Base thisBase : bases) {
			writer.write("{" + thisBase.toString() + "}" + "\n");
		}
		writer.close();
	}

	public void writeDrug(DrugList drugList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (Drug thisDrug : drugList) {
				writer.write("{" + thisDrug.toString() + "}" + "\n");
			}

			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void writeDisease(DiseaseList dList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (Disease thisDisease : dList) {
				writer.write("{" + thisDisease.toString() + "}" + "\n");
			}

			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public void writeMedicalInstitution(MedicalInstitutionList mList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (MedicalInstitution thisMedicalInstitution : mList) {
				writer.write("{" + thisMedicalInstitution.toString() + "}" + "\n");
			}

			writer.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void writePerson(PersonList pList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (Person thisPerson : pList) {
				writer.write("{" + thisPerson.toString() + "}" + "\n");
			}
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void writeServiceFacility(ServiceFacilityList sList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (ServiceFacility thisServiceFacility : sList) {
				writer.write("{" + thisServiceFacility.toString() + "}" + "\n");
			}
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public void writeTreatmentProject(TreatmentProjectList tList, String fileName) {
		FileWriter writer;
		try {
			writer = new FileWriter(fileName, false);
			for (TreatmentProject thisTreatmentProject : tList) {
				writer.write("{" + thisTreatmentProject.toString() + "}" + "\n");
			}
			writer.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
