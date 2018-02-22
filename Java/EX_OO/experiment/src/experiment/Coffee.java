package experiment;

import java.util.ArrayList;

import experiment5.DataField;

public class Coffee extends Product{
	private String origin;
	private String roast;
	private String flavor;
	private String aroma;
	private String acidity;
	private String body;
	public Coffee(String code, String description, double price, String origin, 
			String roast, String flavor,String aroma, String acidity, String body) {
		super(code,description,price);
		this.origin=origin;
		this.roast=roast;
		this.flavor=flavor;
		this.aroma=aroma;
		this.acidity=acidity;
		this.body=body;
	}
	public String getOrigin(){
		return this.origin;
	}
	public String getRoast(){
		return this.roast;
	}
	public String getFlavor(){
		return this.flavor;
	}
	public String getAroma(){
		return this.aroma;
	}
	public String getAcidity(){
		return this.acidity;
	}
	public String getBody(){
		return this.body;
	}
	public String toString(){
		return this.getCode() + "_" + this.getDescription() + "_" + this.getPrice() + "_" + this.getOrigin()
                + "_" + this.getRoast() + "_" + this.getFlavor() + "_" + this.getAroma() + "_"
                + this.getAcidity() + "_" + this.getBody();
	}

	public ArrayList<DataField> getDataFields(){
		ArrayList<DataField> datas=new ArrayList<DataField>();
		datas.add(new DataField("Code",this.getCode()));
		datas.add(new DataField("Description",this.getDescription()));
		datas.add(new DataField("Price",this.getPrice()));
		datas.add(new DataField("Origin",this.getOrigin()));
		datas.add(new DataField("Roast",this.getRoast()));
		datas.add(new DataField("Flavor",this.getFlavor()));
		datas.add(new DataField("Aroma",this.getAroma()));
		datas.add(new DataField("Acidity",this.getAcidity()));
		datas.add(new DataField("Body",this.getBody()));
		return datas;
	}
}