package pers.william.users;

import java.util.List;

import pers.william.orders.Order;

public abstract class Customer extends User{
	int CustomerType;
	String MP;
	String E_Mail;
	String PersionalId;
	String TransactionPassword;
	List<Order> OrderHistoryList;
	
	public abstract boolean regist();
	public abstract boolean placeOrder();
}
