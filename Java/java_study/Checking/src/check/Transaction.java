package check;

public class Transaction {
	private int transNumber;
	private int transId;
	private double transAmt;
	Transaction(){
	}
	Transaction(int transNumber,int transId,double transAmt){
		this.transNumber=transNumber;
		this.transId=transId;
		this.transAmt=transAmt;
	}
	int getTransNumber(){
		return this.transNumber;
	}
	int getTransId(){
		return this.transId;
	}
	int getTransAmt(){
		return this.transNumber;
	}
	void setTransNumber(int TransNumber){
		this.transAmt=TransNumber;
	}
	void setTransId(int TransId){
		this.transId=TransId;
	}
	void setTransAmt(int TransAmt){
		this.transAmt=TransAmt;
	}
	public String toString(int account){
		if(account==this.getTransNumber())
			return "流水序号:"+this.transNumber+"_交易码:"+0+"_交易金额:"+this.transAmt+"\n";
		else return "流水序号:"+this.transNumber+"_交易码:"+this.transId+"_交易金额:"+this.transAmt+"\n";
	}
}
