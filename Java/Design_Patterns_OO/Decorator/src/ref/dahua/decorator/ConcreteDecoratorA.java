package ref.dahua.decorator;

public class ConcreteDecoratorA extends Decorator {

	private String addedState;
	
	public void Operation(){
		
		super.Operation();
		addedState = "New State";
		System.out.println("具体的装饰对象A的操作");
		
	}
	
}
