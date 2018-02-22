package experiment3;

import experiment.OrderItem;
import experiment2.Order;
import experiment2.Sales;

public class XMLSalesFormatter implements SalesFormatter{
	private static XMLSalesFormatter singletonInstance=new XMLSalesFormatter();
	private static final String NEW_LINE=System.getProperty("line.separator");
	public String formatSales(Sales sales){
		String print=NEW_LINE+"<Sales>"+NEW_LINE;
		for(Order order:sales)
        {
            print+="\t<Order total=\""+order.getTotalCost()+"\">"+NEW_LINE;
            for(OrderItem orderitem:order)
            {
            	print+="\t\t<OrderItem quantity=\""+orderitem.getQuantity()+"\" price=\""+
            			orderitem.getProduct().getPrice()+"\">"+orderitem.getProduct().getCode()+"</OrderItem>"+NEW_LINE;
            }
            print+="\t</Order>"+NEW_LINE;
		}
		print+="</Sales>"+NEW_LINE;
		return print;
	}
	public static XMLSalesFormatter getSingletonInstance(){
		return singletonInstance;
	}
}
