package experiment2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import experiment.OrderItem;
import experiment.Product;

public class Order implements Iterable<OrderItem>{
	List<OrderItem> items=new ArrayList<OrderItem>();
	public void addItem(OrderItem oderItem){
		items.add(oderItem);
	}
	public void removeItem(OrderItem orderItem){
		items.remove(orderItem);
	}
	public OrderItem getItem(Product product){
		for(OrderItem orderItem:items){
			if(orderItem.getProduct()==product)return orderItem;
		}
		return null;
	}
	public Iterator<OrderItem> iterator(){
		Iterator<OrderItem> iter=items.iterator();
		return iter;
	}
	public int getNumberOfItems(){
		return items.size();
	}
	public double getTotalCost(){
		double totalcost=0;
		for(OrderItem orderItem:items)
			totalcost+=orderItem.getValue();
		return totalcost;
	}
}
