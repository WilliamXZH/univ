package pers.william.orders;

import java.util.List;

import pers.william.users.Customer;

public class Order {
	int TableId;
	double TotalPrice;
	Customer Person;
	List<DishItem> ItemList;
}
