package experiment2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.swing.DefaultListModel;

import experiment.Product;

public class Catalog implements Iterable<Product>{
	private List<Product> products;
	public Catalog() {
		products=new ArrayList<Product>();
	}
	public void addProduct(Product product){
		products.add(product);
	}
	public Product getProduct(String code){
		for(Product product:products){
			if(product.getCode().equals(code))return product;
		}
		return null;
	}
	public Iterator<Product> iterator(){
		return this.products.iterator();
	}
	public int getNumberOfProducts(){
		return products.size();
	}
	@SuppressWarnings("rawtypes")
	public DefaultListModel getCodes() {
		DefaultListModel listmodel=new DefaultListModel();
		for(Product product:products){
			listmodel.addElement(product.getCode());
		}
		return listmodel;
	}
}
