package list;

import java.util.ArrayList;
import java.util.Iterator;

import base.Disease;
import base.Drug;
import base.Person;

public class PersonList extends ArrayList<Person> {
	
	public PersonList() {
		super();
	}
	
	public Person getPerson(String ID) {
		if (ID == null) {
			return null;
		}
		for (Person currentPerson : this) {
			if (currentPerson.getID().equals(ID)) {
				return currentPerson;
			}
		}
		return null;
	}


	public void replacePerson(Person newPerson, Person oldPerson) {
		for (Person p : this) {
			if (p.equals(oldPerson)) {
				this.remove(p);
				break;
			}
		}
		this.add(newPerson);
	}

}
