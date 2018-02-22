package base;

public class Drug extends Base {
	private String english;// 英文名称
	private String prescriptionSign;// 处方药标志
	private String feeLevel;// 收费项目等级
	private String doseUnit;// 药品剂量单位
	private double ceilingPrice;// 最高价
	private String hospitalPreparationMark;// 医院等级
	private String frequency;// 使用频次
	private String factory;// 工厂
	private String notes;// 备注
	private String usage;// 用法
	private String units;// 单位
	private String specification; // 规格
	private String place;// 产地
	private String codeOfNationalDirectory;// 国家目录编码
	private String nationalDrugCertificate;// 国药准字
	private String tradeName;// 商品名
	private String limitRange;// 限制使用范围
	private String approvalMark;// 审批标志
	private String limitDays;// 限定天数

	public Drug(String _code, String _name, String _english, String _chargeClass, String _prescriptionSign,
			String _feeLevel, String _doseUnit, double _ceilingPrice, double _price, String _hospitalPreparationMark,
			String _frequency, String _factory, String _notes, String _usage, String _units, String _specification,
			String _place, String _codeOfNationalDirectory, String _nationalDrugCertificate, String _tradeName,
			String _limitRange, String _approvalMark, String _limitDays) {
		super(_code, _name, _price,_chargeClass);
		english = _english;
		prescriptionSign = _prescriptionSign;
		feeLevel = _feeLevel;
		doseUnit = _doseUnit;
		ceilingPrice = _ceilingPrice;
		hospitalPreparationMark = _hospitalPreparationMark;
		frequency = _frequency;
		factory = _factory;
		notes = _notes;
		usage = _usage;
		units = _units;
		specification = _specification;
		place = _place;
		codeOfNationalDirectory = _codeOfNationalDirectory;
		tradeName = _tradeName;
		limitRange = _limitRange;
		approvalMark = _approvalMark;
		limitDays = _limitDays;
	}

	public Drug() {

	}

	public String getEnglish() {
		return english;
	}

	public String getPrescriptionSign() {
		return prescriptionSign;
	}

	public String getFeeLevel() {
		return feeLevel;
	}

	public String getDoseUnit() {
		return doseUnit;
	}

	public double getCeilingPrice() {
		return ceilingPrice;
	}

	public String getHospitalPreparationMark() {
		return hospitalPreparationMark;
	}

	public String getFrequency() {
		return frequency;
	}

	public String getFactory() {
		return factory;
	}

	public String getNotes() {
		return notes;
	}

	public String getUsage() {
		return usage;
	}

	public String getUnits() {
		return units;
	}

	public String getSpecification() {
		return specification;
	}

	public String getPlace() {
		return place;
	}

	public String getCodeOfNationalDirectory() {
		return codeOfNationalDirectory;
	}

	public String getNationalDrugCertificate() {
		return nationalDrugCertificate;
	}

	public String getTradeName() {
		return tradeName;
	}

	public String getLimitRange() {
		return limitRange;
	}

	public String getApprovalMark() {
		return approvalMark;
	}

	public String getLimitDays() {
		return limitDays;
	}

	public void setEnglish(String english) {
		this.english = english;
	}

	public void setPrescriptionSign(String prescriptionSign) {
		this.prescriptionSign = prescriptionSign;
	}

	public void setFeeLevel(String feeLevel) {
		this.feeLevel = feeLevel;
	}

	public void setDoseUnit(String doseUnit) {
		this.doseUnit = doseUnit;
	}

	public void setCeilingPrice(double ceilingPrice) {
		this.ceilingPrice = ceilingPrice;
	}

	public void setHospitalPreparationMark(String hospitalPreparationMark) {
		this.hospitalPreparationMark = hospitalPreparationMark;
	}

	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}

	public void setFactory(String factory) {
		this.factory = factory;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public void setUsage(String usage) {
		this.usage = usage;
	}

	public void setUnits(String units) {
		this.units = units;
	}

	public void setSpecification(String specification) {
		this.specification = specification;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public void setCodeOfNationalDirectory(String codeOfNationalDirectory) {
		this.codeOfNationalDirectory = codeOfNationalDirectory;
	}

	public void setNationalDrugCertificate(String nationalDrugCertificate) {
		this.nationalDrugCertificate = nationalDrugCertificate;
	}

	public void setTradeName(String tradeName) {
		this.tradeName = tradeName;
	}

	public void setLimitRange(String limitRange) {
		this.limitRange = limitRange;
	}

	public void setApprovalMark(String approvalMark) {
		this.approvalMark = approvalMark;
	}

	public void setLimitDays(String limitDays) {
		this.limitDays = limitDays;
	}

	@Override
	public String toString() {
		return super.toString()+",\"english\": \"" + english + "\",\"prescriptionSign\": \"" + prescriptionSign + "\",\"feeLevel\": \""
				+ feeLevel + "\",\"doseUnit\": \"" + doseUnit + "\",\"ceilingPrice\": \"" + ceilingPrice
				+ "\",\"hospitalPreparationMark\": \"" + hospitalPreparationMark + "\",\"frequency\": \"" + frequency
				+ "\",\"factory\": \"" + factory + "\",\"notes\": \"" + notes + "\",\"usage\": \"" + usage
				+ "\",\"units\": \"" + units + "\",\"specification\": \"" + specification + "\",\"place\": \"" + place
				+ "\",\"codeOfNationalDirectory\": \"" + codeOfNationalDirectory + "\",\"nationalDrugCertificate\": \""
				+ nationalDrugCertificate + "\",\"tradeName\": \"" + tradeName + "\",\"limitRange\": \"" + limitRange
				+ "\",\"approvalMark\": \"" + approvalMark + "\",\"limitDays\": \"" + limitDays + "\"";
	}
}
