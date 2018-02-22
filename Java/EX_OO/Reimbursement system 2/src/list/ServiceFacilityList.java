package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.Drug;
import base.Person;
import base.ServiceFacility;

public class ServiceFacilityList extends ArrayList<ServiceFacility> {

	public ServiceFacilityList() {
		super();
	}

	public ServiceFacility getServiceFacility(String code) {
		if (code == null) {
			return null;
		}
		for (ServiceFacility currentServiceFacility : this) {
			if (currentServiceFacility.getName().equals(code)) {
				return currentServiceFacility;
			}
		}
		return null;
	}


}
