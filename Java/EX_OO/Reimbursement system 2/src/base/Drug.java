package base;

public class Drug extends Base {
	private String english;// Ӣ������
	private String prescriptionSign;// ����ҩ��־
	private String feeLevel;// �շ���Ŀ�ȼ�
	private String doseUnit;// ҩƷ������λ
	private double ceilingPrice;// ��߼�
	private String hospitalPreparationMark;// ҽԺ�ȼ�
	private String frequency;// ʹ��Ƶ��
	private String factory;// ����
	private String notes;// ��ע
	private String usage;// �÷�
	private String units;// ��λ
	private String specification; // ���
	private String place;// ����
	private String codeOfNationalDirectory;// ����Ŀ¼����
	private String nationalDrugCertificate;// ��ҩ׼��
	private String tradeName;// ��Ʒ��
	private String limitRange;// ����ʹ�÷�Χ
	private String approvalMark;// ������־
	private String limitDays;// �޶�����

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
