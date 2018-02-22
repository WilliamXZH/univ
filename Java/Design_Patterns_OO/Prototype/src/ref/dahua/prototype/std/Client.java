package ref.dahua.prototype.std;

public class Client {

	public static void main(String[] args) {
		ConcretePrototype1 p1 = new ConcretePrototype1("I");
		ConcretePrototype1 c1 = (ConcretePrototype1) p1.Clone();
		System.out.println("Cloned:"+c1.getId());
		System.out.println(p1.hashCode()+":"+c1.hashCode());
		System.out.println(p1.getId().hashCode()+":"+c1.getId().hashCode());
		
	}
	
}
