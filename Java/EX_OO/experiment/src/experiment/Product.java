package experiment;

import java.util.ArrayList;

import experiment5.DataField;

public class Product{
	private String code;
	private String description;
	private double price;
	public Product(String code,String description,double price){
		this.code=code;
		this.description=description;
		this.price=price;
	}
	public String getCode(){
		return this.code;
	}
	public String getDescription(){
		return this.description;
	}
	public double getPrice(){
		return this.price;
	}
	public boolean equals(Object object){
		Product product=(Product)object;
		if(this.code.equals(product.code))return true;
		else return false;
	}
	public boolean equals(String string){
		if(this.code.equals(string))return true;
		else return false;
	}
	public String toString(){
		return this.code + "_" + this.description + "_" + this.price;
	}
	public ArrayList<DataField> getDataFields(){
		ArrayList<DataField> datas=new ArrayList<DataField>();
		datas.add(new DataField("Code",this.getCode()));
		datas.add(new DataField("Descruption",this.getDescription()));
		datas.add(new DataField("Price",getPrice()));
		return datas;
	}
}