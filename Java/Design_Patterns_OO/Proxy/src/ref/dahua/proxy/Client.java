package ref.dahua.proxy;

public class Client {

	public static void main(String[] args) {
			
		SchoolGirl jiaojiao = new SchoolGirl();
		jiaojiao.setName("¿ÓΩøΩø");
		
		Proxy daili = new Proxy(jiaojiao);
		daili.giveDolls();
		daili.giveFlows();
		daili.giveChocolate();
		
	}
	
	
}
