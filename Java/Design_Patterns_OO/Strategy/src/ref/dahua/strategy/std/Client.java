package ref.dahua.strategy.std;

public class Client {

	public static void main(String[] args) {
		Context context;
		
		context = new Context(new ConcreteStrategyA());
		context.ContextInterface();
		
		context = new Context(new ConcreteStrategyB());
		context.ContextInterface();
	}
	
}
