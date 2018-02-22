package ref.dahua.decorator;

public class ConcreteDecoratorB extends Decorator {

	public void Operation(){
		
		super.Operation();
		addedBehavior();
		System.out.println("����װ�ζ���B�ز���");
		
	}
	
	private void addedBehavior(){
		
		System.out.println("addedBehavior()");
		
	}
	
}
