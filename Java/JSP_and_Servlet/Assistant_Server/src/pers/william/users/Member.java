package pers.william.users;

public class Member extends NonAdmin{
	String telnum;
	String company;
	
	public String getTel(){
		return this.telnum;
	}
	public String getCom(){
		return this.company;
	}
	public void setTel(String t){
		this.telnum=t;
	}
	public void setCom(String c){
		this.company=c;
	}
	
	public Member(){
		super(-1,3,null,null);
	}
	public Member(String nm,String pwd,String tel,String com){
		super(nm,pwd);
		this.telnum=tel;
		this.company=com;
	}
}
