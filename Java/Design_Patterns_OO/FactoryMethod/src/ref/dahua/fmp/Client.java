package ref.dahua.fmp;

public class Client {

	public static void main(String[] args) {
		IFactory factory = new UndergraduateFactory();
		LeiFeng student = factory.CreateLeiFeng();
		
		student.buyRice();
		student.sweep();
		student.wash();
		
	}
	
}
