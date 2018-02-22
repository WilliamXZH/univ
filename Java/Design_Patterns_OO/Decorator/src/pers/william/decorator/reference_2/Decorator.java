package pers.william.decorator.reference_2;

public abstract class Decorator implements VisualComponent{
	protected VisualComponent component;
	public Decorator(){
		
	}
	public Decorator(VisualComponent component){
		this.component=component;
	}
	public void setComponent(VisualComponent component){
		this.component=component;
	}
	
	public abstract void draw();
}
