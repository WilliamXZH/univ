package pers.william.users;

public abstract class Staff extends User {
	int StaffType;
	String StaffId;
	
	@Override
	public boolean login() {return false;} 
	
	public void advice(){}
}
