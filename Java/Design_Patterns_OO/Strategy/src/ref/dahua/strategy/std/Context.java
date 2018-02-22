package ref.dahua.strategy.std;

public class Context {

	Strategy strategy;
	public Context(Strategy strategy){
		this.strategy = strategy;
	}
	
	public void ContextInterface(){
		strategy.AlgorithmInterface();
	}
	
}
