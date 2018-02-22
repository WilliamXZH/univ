package ref.dahua.op.pre;

public class Client {

	public static void main(String[] args) {
		
		Secretary tongzizhe = new Secretary();

		StockObserver tongshi1 = new StockObserver("魏观姹",tongzizhe);
		StockObserver tongshi2 = new StockObserver("易管查",tongzizhe);
		
		tongzizhe.attach(tongshi1);
		tongzizhe.attach(tongshi2);
		
		tongzizhe.setAction("老板回来了");
		
		tongzizhe.Notify();
		
	}
	
}
