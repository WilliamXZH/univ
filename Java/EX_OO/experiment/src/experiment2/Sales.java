package experiment2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Sales implements Iterable<Order>{
	List<Order> orders=new ArrayList<Order>();
	public void addOrder(Order order){
		orders.add(order);
	}
	public Iterator<Order> iterator(){
		return orders.iterator();
	}
	public int getNumberOfOrders(){
		return orders.size();
	}
}
