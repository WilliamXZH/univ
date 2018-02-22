package base;

public class TreatmentProject extends Base {

	private String chargeClass;
	private String chargeLevel;
	private String hospitalLevel;
	private String approvalMark;
	private String unit;
	private String factory;
	private String notes;
	private String limitRange;// 限制使用范围

	public TreatmentProject(String code, String name, double price, String chargeClass, String chargeLevel,
			String hospitalLevel, String approvalMark, String unit, String factory, String notes, String limitRange) {
		super(code, name, price,chargeClass);
		this.chargeLevel = chargeLevel;
		this.hospitalLevel = hospitalLevel;
		this.approvalMark = approvalMark;
		this.unit = unit;
		this.factory = factory;
		this.notes = notes;
		this.limitRange = limitRange;
	}


	public String getChargeLevel() {
		return chargeLevel;
	}

	public String getHospitalLevel() {
		return hospitalLevel;
	}

	public String getApprovalMark() {
		return approvalMark;
	}

	public String getUnit() {
		return unit;
	}

	public String getFactory() {
		return factory;
	}

	public String getNotes() {
		return notes;
	}

	public String getLimitRange() {
		return limitRange;
	}

	public void setChargeLevel(String chargeLevel) {
		this.chargeLevel = chargeLevel;
	}

	public void setHospitalLevel(String hospitalLevel) {
		this.hospitalLevel = hospitalLevel;
	}

	public void setApprovalMark(String approvalMark) {
		this.approvalMark = approvalMark;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public void setLimitRange(String limitRange) {
		this.limitRange = limitRange;
	}

	@Override
	public String toString() {
		return super.toString()+",\"chargeClass\": \"" + chargeClass + "\",\"chargeLevel\": \"" + chargeLevel + "\",\"hospitalLevel\": \""
				+ hospitalLevel + "\",\"approvalMark\": \"" + approvalMark + "\",\"unit\": \"" + unit
				+ "\",\"factory\": \"" + factory + "\",\"notes\": \"" + notes + "\",\"limitRange\": \"" + limitRange
				+ "\"";
	}

}
