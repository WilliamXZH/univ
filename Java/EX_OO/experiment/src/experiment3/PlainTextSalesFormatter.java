package experiment3;

import experiment.OrderItem;
import experiment2.Order;
import experiment2.Sales;

//import java.util.Iterator;

public class PlainTextSalesFormatter implements SalesFormatter{
	private static PlainTextSalesFormatter singletonInstance=new PlainTextSalesFormatter();
	private static final String NEW_LINE=System.getProperty("line.separator");
	private PlainTextSalesFormatter(){
	}
	public String formatSales(Sales sales){
		String print= "";
		int num=0;
		for(Order order:sales){
			print+="----------------------"+NEW_LINE+"Order "+(++num)+NEW_LINE+NEW_LINE;
		    for(OrderItem orderItem:order){
		     	print+=orderItem.toString()+NEW_LINE;
		    }
		print+=NEW_LINE+"Total="+order.getTotalCost()+NEW_LINE;
		}
		return print;
	}
	public static PlainTextSalesFormatter getSingletonInstance(){
		return singletonInstance;
	}
}
