package experiment3;

import javax.sound.sampled.Line;

import experiment.OrderItem;
import experiment2.Order;
import experiment2.Sales;

public class HTMLSalesFormatter implements SalesFormatter{
	private static HTMLSalesFormatter singletonInstance=new HTMLSalesFormatter();
	private static final String NEW_LINE=System.getProperty("line.separator");
	public static HTMLSalesFormatter getSingletonInstance(){
		return singletonInstance;
	}
	public String formatSales(Sales sales){
		String print=NEW_LINE+"<html>"+NEW_LINE+"<body>"+NEW_LINE+"<center><h2>Orders</h2></center>"+NEW_LINE;
		for(Order order:sales){
			print+="\t<hr>"+NEW_LINE+"\t<h4>Total="+order.getTotalCost()+"</h4>"+NEW_LINE;
			for(OrderItem orderitem:order){
				print+="\t<p>"+NEW_LINE+"\t\t<b>code:</b>"+orderitem.getProduct().getCode()+"<br>"+NEW_LINE+
						"\t\t<b>quantity:</b>"+orderitem.getQuantity()+"<br>"+NEW_LINE+
						"\t\t<b>price:</b>"+orderitem.getProduct().getPrice()+NEW_LINE+"\t</p>"+NEW_LINE;
			}
		}
		print+="</body>"+NEW_LINE+"</html>";
		return print;
	}
}
