package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.Disease;

public class DiseaseList extends ArrayList<Disease> {
	
	public DiseaseList() {
		super();
	}

	public Disease getDisease(String code) {
		if (code == null) {
			return null;
		}
		for (Disease currentDisease : this) {
			if (currentDisease.getCode().equals(code)) {
				return currentDisease;
			}
		}
		return null;
	}


}
