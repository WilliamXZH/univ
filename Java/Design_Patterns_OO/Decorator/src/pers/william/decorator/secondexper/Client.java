package pers.william.decorator.secondexper;

public class Client {
	public void client(){
		Component title=new TitleDecorator(new Title());
		title.draw();
		
		Component receipt=new ReceiptDecorator(
						new CheckDecorator(
								new ShoppingList()));
		receipt.draw();
	}
}
