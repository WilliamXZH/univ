package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.TreatmentProject;

public class TreatmentProjectList extends ArrayList<TreatmentProject>{
	public TreatmentProjectList() {
		super();
	}

	
	public TreatmentProject getTreatmentProject(String code) {
		if (code == null) {
			return null;
		}
		for (TreatmentProject currentTreatmentProject : this) {
			if (currentTreatmentProject.getName().equals(code)) {
				return currentTreatmentProject;
			}
		}
		return null;
	}


}
