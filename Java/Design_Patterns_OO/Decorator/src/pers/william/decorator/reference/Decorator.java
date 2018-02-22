package pers.william.decorator.reference;

public abstract class Decorator implements Component{
	protected Component cp;
	
	Decorator(Component component){
		cp = component;
	}
	public abstract void draw();
}
