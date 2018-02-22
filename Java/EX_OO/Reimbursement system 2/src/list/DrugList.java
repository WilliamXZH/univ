package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.Disease;
import base.Drug;

public class DrugList extends ArrayList<Drug> {
	public DrugList() {
		super();
	}
	public Drug getDrug(String name) {
		for (Drug d : this) {
			if (d.getName().equals(name)) {
				return d;
			}
		}
		return null;
	}
	public void delDrug(Drug drug) {
		for (Drug d : this) {
			if (d.equals(drug)) {
				this.remove(d);
				break;
			}
		}
	}

	public void replaceDrug(Drug newDrug, Drug oldDrug) {
		for (Drug d : this) {
			if (d.equals(oldDrug)) {
				this.remove(d);
				break;
			}
		}
		this.add(newDrug);
	}
}
