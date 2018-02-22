package ref.dahua.strategy;

public class Client {

	double total = 0.0d;
	
	public void click(double money){
		
		CashContext cc = new CashContext("");
		
		double res = cc.GetRsult(money);
		
		total += res;
		
	}
	
}
