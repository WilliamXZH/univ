package ref.dahua.op.pre;

public class Client {

	public static void main(String[] args) {
		
		Secretary tongzizhe = new Secretary();

		StockObserver tongshi1 = new StockObserver("κ���",tongzizhe);
		StockObserver tongshi2 = new StockObserver("�׹ܲ�",tongzizhe);
		
		tongzizhe.attach(tongshi1);
		tongzizhe.attach(tongshi2);
		
		tongzizhe.setAction("�ϰ������");
		
		tongzizhe.Notify();
		
	}
	
}
