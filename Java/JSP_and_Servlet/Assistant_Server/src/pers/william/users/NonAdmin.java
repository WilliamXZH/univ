package pers.william.users;

public class NonAdmin implements User{

	private int id=-1;
	private int type=-1;
	private String name=null;
	private String password=null;
	
	public NonAdmin(){
		this(null,null);
	}
	public NonAdmin(String nm,String pwd){
		this.name=nm;
		this.password=pwd;
	}	
	public NonAdmin(int id,int type,String nm,String pwd){
		this(nm,pwd);
		this.id=id;
		this.type=type;
	}
	
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
		this.id=id;
		
	}
}
