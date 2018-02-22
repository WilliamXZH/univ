package experiment;

import java.util.ArrayList;
import experiment5.DataField;

public class CoffeeBrewer extends Product{
	private String model;
	private String waterSupply;
	private int numberOfCups;
	public CoffeeBrewer(String code, String description, double price, String model, String waterSupply, int numberOfCups) {
		super(code, description, price);
		this.model=model;
		this.waterSupply=waterSupply;
		this.numberOfCups=numberOfCups;
	}
	public String getModel(){
		return this.model;
	}
	public String getWaterSupply(){
		return this.waterSupply;
	}
	public int getNumberOfCups(){
		return this.numberOfCups;
	}
	public String toString(){
		return this.getCode() + "_" + this.getDescription() + "_" + this.getPrice() + "_"
                + this.getModel() + "_" +this.getWaterSupply() + "_" + this.getNumberOfCups();
	}
	public ArrayList<DataField> getDataFields(){
		ArrayList<DataField> datas=new ArrayList<DataField>();
		datas.add(new DataField("Code",this.getCode()));
		datas.add(new DataField("Descruption",this.getDescription()));
		datas.add(new DataField("Price",getPrice()));
		datas.add(new DataField("Model",this.getModel()));
		datas.add(new DataField("WaterSupply",this.getWaterSupply()));
		datas.add(new DataField("NumberOfCups",getNumberOfCups()));
		return datas;
	}
}