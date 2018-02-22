package base;

public class ServiceFacility extends Base {

	private String notes;
	private String limitRange;// 限制使用范围

	public ServiceFacility(String code, String name, double price, String feeClass, String notes, String limitRange) {
		super(code, name, price,feeClass);
		this.notes = notes;
		this.limitRange = limitRange;
	}

	public String getNotes() {
		return notes;
	}

	public String getLimitRange() {
		return limitRange;
	}


	public void setNotes(String notes) {
		this.notes = notes;
	}

	public void setLimitRange(String limitRange) {
		this.limitRange = limitRange;
	}

	@Override
	public String toString() {
		return super.toString()+",\"notes\": \"" + notes + "\",\"limitRange\": \"" + limitRange + "\"";
	}

}
