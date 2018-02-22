package base;

public class Base {
	private String code;// ±àºÅ
	private String name;// Ãû³Æ
	private double price;// ¼Û¸ñ
	private String chargeClass;
	public Base(String code, String name, double price, String chargeClass) {
		this.code = code;
		this.name = name;
		this.price = price;
		this.chargeClass = chargeClass;
	}

	public String getChargeClass() {
		return chargeClass;
	}

	public void setChargeClass(String chargeClass) {
		this.chargeClass = chargeClass;
	}

	public Base() {
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	public double getPrice() {
		return price;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((code == null) ? 0 : code.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		if (obj == null) {
			return false;
		}
		if (!(obj instanceof Base)) {
			return false;
		}
		Base other = (Base) obj;
		if (code == null) {
			if (other.code != null) {
				return false;
			}
		} else if (!code.equals(other.code)) {
			return false;
		}
		return true;
	}

	@Override
	public String toString() {
		return "\"code\": \"" + code + "\",\"name\": \"" + name + "\",\"price\": \"" + price + "\",\"chargeClass\": \""
				+ chargeClass + "\"";
	}

}
