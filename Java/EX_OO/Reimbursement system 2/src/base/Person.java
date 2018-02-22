package base;

import java.text.ParseException;
import java.util.Date;

import tool.DateFormatter;

public class Person {

	private String name;
	private String ID;
	private String gender;
	private Date birthday;
	private String hospitalCode;
	private String medicalCategory;// 医疗人员类别
	private String unitNumber;// 单位编号
	private String unitName;// 证件名称
	private int hospitalizationTimes;// 住院次数
	private Date dischargeDate;// 上次出院时间
	private String dischargeDiagnosis;// 上次出院诊断
	private double reimbursementSumOfYear;// 本年中心报销累计
	private double personalExpenseSumOfYear;// 本年个人自费累计
	private double totalExpenseOfYear;// 本年医疗费用累计
	
	public Person() {
		Date defaultDate;
		try {
			defaultDate = DateFormatter.stringToDay("1970-1-1");
			dischargeDate=defaultDate;
			birthday=defaultDate;
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}
	public Person(String name, String iD, String gender, Date birthday, String medicalCategory,
			String unitNumber, String unitName, int hospitalizationTimes, Date dischargeDate,
			String dischargeDiagnosis, double reimbursementSumOfYear, double personalExpenseSumOfYear,
			double totalExpenseOfYear,String hospitalCode) {
		super();
		this.name = name;
		ID = iD;
		this.gender = gender;
		this.birthday = birthday;
		this.medicalCategory = medicalCategory;
		this.unitNumber = unitNumber;
		this.unitName = unitName;
		this.hospitalizationTimes = hospitalizationTimes;
		this.dischargeDate = dischargeDate;
		this.dischargeDiagnosis = dischargeDiagnosis;
		this.reimbursementSumOfYear = reimbursementSumOfYear;
		this.personalExpenseSumOfYear = personalExpenseSumOfYear;
		this.totalExpenseOfYear = totalExpenseOfYear;
		this.hospitalCode=hospitalCode;
	}

	public String getHospitalCode() {
		return hospitalCode;
	}
	public void setHospitalCode(String hospitalCode) {
		this.hospitalCode = hospitalCode;
	}
	public String getName() {
		return name;
	}

	public String getID() {
		return ID;
	}

	public String getGender() {
		return gender;
	}

	public String getBirthday() {
		return DateFormatter.dayToString(birthday);
	}

	public String getMedicalCategory() {
		return medicalCategory;
	}

	public String getUnitNumber() {
		return unitNumber;
	}

	public String getUnitName() {
		return unitName;
	}

	public int getHospitalizationTimes() {
		return hospitalizationTimes;
	}

	public Date getDischargeDate() {
		return dischargeDate;
	}

	public String getDischargeDiagnosis() {
		return dischargeDiagnosis;
	}

	public double getReimbursementSumOfYear() {
		return reimbursementSumOfYear;
	}

	public double getPersonalExpenseSumOfYear() {
		return personalExpenseSumOfYear;
	}

	public double getTotalExpenseOfYear() {
		return totalExpenseOfYear;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public void setMedicalCategory(String medicalCategory) {
		this.medicalCategory = medicalCategory;
	}

	public void setUnitNumber(String unitNumber) {
		this.unitNumber = unitNumber;
	}

	public void setUnitName(String unitName) {
		this.unitName = unitName;
	}

	public void setHospitalizationTimes(int hospitalizationTimes) {
		this.hospitalizationTimes = hospitalizationTimes;
	}

	public void setDischargeDate(Date dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public void setDischargeDiagnosis(String dischargeDiagnosis) {
		this.dischargeDiagnosis = dischargeDiagnosis;
	}

	public void setReimbursementSumOfYear(double reimbursementSumOfYear) {
		this.reimbursementSumOfYear = reimbursementSumOfYear;
	}

	public void setPersonalExpenseSumOfYear(double personalExpenseSumOfYear) {
		this.personalExpenseSumOfYear = personalExpenseSumOfYear;
	}

	public void setTotalExpenseOfYear(double totalExpenseOfYear) {
		this.totalExpenseOfYear = totalExpenseOfYear;
	}

	@Override
	public String toString() {
		return "\"name\": \"" + name + "\",\"ID\": \"" + ID + "\",\"gender\": \"" + gender + "\",\"birthday\": \""
				+ DateFormatter.dayToString(birthday) + "\",\"hospitalCode\": \"" + hospitalCode + "\",\"medicalCategory\": \"" + medicalCategory
				+ "\",\"unitNumber\": \"" + unitNumber + "\",\"unitName\": \"" + unitName
				+ "\",\"hospitalizationTimes\": \"" + hospitalizationTimes + "\",\"dischargeDate\": \"" + DateFormatter.dayToString(dischargeDate)
				+ "\",\"dischargeDiagnosis\": \"" + dischargeDiagnosis + "\",\"reimbursementSumOfYear\": \""
				+ reimbursementSumOfYear + "\",\"personalExpenseSumOfYear\": \"" + personalExpenseSumOfYear
				+ "\",\"totalExpenseOfYear\": \"" + totalExpenseOfYear+"\"";
	}
}
