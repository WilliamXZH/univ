package ref.dahua.decorator;

public abstract class Decorator implements Component {

	protected Component component;
	
	public void setComponent(Component component) {
		this.component = component;
	}

	public void Operation() {
		// TODO Auto-generated method stub
		if(component != null){
			component.Operation();
		}

	}

}
