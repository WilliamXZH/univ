package ref.dahua.strategy.sf;

public class CashFactory {
	

	public CashSuper createCashAccept(String type){
		CashSuper cs = null;
		
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
		return cs;
	}
	
}
