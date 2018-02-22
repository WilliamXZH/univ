package pers.william.users;

public interface User {
	
	
	public int getId();
	public int getType();
	public String getName();
	public String getPassword();
	
	public void setId(int id);
	public void setType(int typ);
	public void setName(String nm);
	public void setPassword(String psw);
	
	
}
