package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.Disease;
import base.MedicalInstitution;

public class MedicalInstitutionList extends ArrayList<MedicalInstitution> {
	public MedicalInstitutionList() {
		super();
	}
	public MedicalInstitution getMedicalInstitution(String code) {
		if (code == null) {
			return null;
		}
		for (MedicalInstitution currentMedicalInstitution : this) {
			if (currentMedicalInstitution.getCode().equals(code)) {
				return currentMedicalInstitution;
			}
		}
		return null;
	}


}
