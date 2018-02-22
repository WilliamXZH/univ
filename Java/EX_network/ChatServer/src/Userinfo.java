
public class Userinfo {
	private String name;
	private String pass;
	private boolean status;
	Userinfo(String name,String pass){
		this.name=name;
		this.pass=pass;
		this.status=false;
	}
	public String getName() {
		// TODO Auto-generated method stub
		return this.name;
	}
	public String getpass(){
		return this.pass;
	}
	public boolean getstatus(){
		return this.status;
		
	}
	public void setstatus(boolean s){
		this.status=s;
	}
	

}
