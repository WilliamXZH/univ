package pers.william.users;

public class Administrator implements User{

	private int id=0;
	int type=0;
	String name=null;
	String password=null;
	
	@Override
	public int getId() {
		// TODO Auto-generated method stub
		return this.id;
	}

	@Override
	public int getType() {
		// TODO Auto-generated method stub
		return this.type;
	}

	@Override
	public String getName() {
		// TODO Auto-generated method stub
		return this.name ;
	}

	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return this.password;
	}

	@Override
	public void setType(int typ) {
		// TODO Auto-generated method stub
		this.type=typ;
	}

	@Override
	public void setName(String nm) {
		// TODO Auto-generated method stub
		this.name=nm;
	}

	@Override
	public void setPassword(String psw) {
		// TODO Auto-generated method stub
		this.password=psw;
	}

	@Override
	public void setId(int id) {
		// TODO Auto-generated method stub
		this.id=id;
	}
	
}
