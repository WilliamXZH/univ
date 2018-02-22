package ref.dahua.decorator;

public class ConcreteDecoratorB extends Decorator {

	public void Operation(){
		
		super.Operation();
		addedBehavior();
		System.out.println("具体装饰对象B地操作");
		
	}
	
	private void addedBehavior(){
		
		System.out.println("addedBehavior()");
		
	}
	
}
