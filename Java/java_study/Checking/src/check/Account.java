package check;

public class Account {
	double balance=0;
	String name;
	public Account()
	{
		name="";
		balance=0;
	}
	public Account(String Name,double Balance)
	{
		this.name=Name;
		this.balance=Balance;
	}
	double getBalance(){
		return this.balance;
	}
	String getName(){
		return this.name;
	}
	void setBalance(double Balance){
		this.balance=Balance;
	}
	void setName(String Name){
		this.name=Name;
	}
}
