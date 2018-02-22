package check;

import java.util.ArrayList;

public class CheckingAccount extends Account{
	private int transCount=0;
	private float total=0;
	ArrayList<Transaction> TransList=new ArrayList<Transaction>();
	public CheckingAccount(){
		super();
		this.total=0;
	}
	public CheckingAccount(String Name,double Balance,float total){
		super();
		this.total=total;
	}
	float getTotal(){
		return this.total;
	}
	void setTotal(float Total){
		this.total=Total;
	}
	void addTrans(int transNumber,int transId,int transAmt){
		Transaction trans=new Transaction(transNumber,transId,transAmt);
		TransList.add(trans);
	}
	Transaction getTrans(int TransNumber){
		for(Transaction trans:this.TransList){
			if(trans.getTransNumber()==TransNumber){
				return trans;
			}
		}
		return null;
	}
	int getTransCount(){
		return this.transCount;
	}
	void Deposit(){
		
	}
	void Draw(){
		
	}
	void check(int num,double amount){
		double expend=0;
		System.out.println("当前余额:"+this.getBalance()+"_总服务支出:"+this.getTotal());
		if(num==1&&balance-amount<0){
			expend=10;
		}
		else if(balance<50){
			System.out.println("warning:...");
		}
		else if(balance<500){
			if(this.getTransCount()==0){
				expend=5;
			}
		}
		else{
			if(num==1){
				expend=1.5;
			}
			else if(num==2){
				expend=1;
			}
			else return;//error
		}
		total+=expend;
		if(num==1){
			balance-=amount;
		}
		else{
			balance+=amount;
		}
		transCount++;
		Transaction trans=new Transaction(transCount,num,amount);
		this.TransList.add(trans);
		System.out.println(trans.toString(-1));
	}
	String ListAll(int num){
		String message="";
		for(Transaction trans:this.TransList){
			if(trans.getTransId()!=num)
				message+=trans.toString(this.getTransCount());
		}
		return message;
	}
}
