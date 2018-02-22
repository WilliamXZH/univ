package pers.william.decorator.secondexper;

abstract class Decorator implements Component {
	
	protected Component component;

	Decorator(Component component){
		this.component=component;
	}
	
	public abstract void draw();

}
