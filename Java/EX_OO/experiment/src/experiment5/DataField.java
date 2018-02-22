package experiment5;

public class DataField {
	private String name;
	private String value;
	public DataField(String initName,String initValue){
		this.name=initName;
		this.value=initValue;
	}
	public DataField(String initName,double initValue){
		this.name=initName;
		this.value=""+initValue;
	}
	public String getName(){
		return this.name;
	}
	public String getValue(){
		return this.value;
	}
}
