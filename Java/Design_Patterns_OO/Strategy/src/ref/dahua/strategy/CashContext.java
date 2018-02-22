package ref.dahua.strategy;

import ref.dahua.strategy.sf.*;

public class CashContext {

	private CashSuper cs;
	
	public CashContext(String type){
		
		switch(type){
		
		case "�����շ�":
			cs = new CashNormal();
			break;
		case "��300��100":
			cs = new CashReturn("300","100");
			break;
		case "��8��":
			cs = new CashRebate("0.8");
			break;
		}
	}
	
	public double GetRsult(double money){
		return cs.acceptCash(money);
	}
	
}
