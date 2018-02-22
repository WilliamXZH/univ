package ref.dahua.tmp.std;

public class Client {

	public static void main(String[] args) {
		AbstractClass c;
		
		c = new ConcreteClassA();
		c.templateMethod();
		
		c = new ConcreteClassB();
		c.templateMethod();
		
	}
	
}
