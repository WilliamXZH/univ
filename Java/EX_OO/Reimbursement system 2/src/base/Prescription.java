package base;

public class Prescription {
	private String code;
	private String admissionNumber;
	private String base;
	private String preClass;
	private int amount;
	private double price;
	public Prescription() {}
	public Prescription(String base, double price, int amount) {
		super();
		this.base = base;
		this.amount = amount;
	}
	public String getBase() {
		return base;
	}
	public int getAmount() {
		return amount;
	}
	public void setBase(String base) {
		this.base = base;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getCode() {
		return code;
	}
	public String getAdmissionNumber() {
		return admissionNumber;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public void setAdmissionNumber(String admissionNumber) {
		this.admissionNumber = admissionNumber;
	}
	public String getPreClass() {
		return preClass;
	}
	public void setPreClass(String preClass) {
		this.preClass = preClass;
	}
}
