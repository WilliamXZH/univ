package pers.william.decorator.reference_2;

public class Client {
	public void client(){
		VisualComponent component=
				new BorderDecorator(
						new ScrollDecorator(
								new TextView()));
		
//		VisualComponent border=new BorderDecorator();
//		VisualComponent scroll=new ScrollDecorator();
//		VisualComponent text=new TextView();
//		border.setComponent(scroll);
//		scroll.setComponent(text);
		
		component.draw();
	}
}
