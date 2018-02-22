package base;

public class Disease {
	private String code;
	private String name;
	private String cetegory;
	private String reimbursementMark;
	private String notes;

	public Disease(String code, String name, String cetegory, String reimbursementMark, String notes) {
		this.code = code;
		this.name = name;
		this.cetegory = cetegory;
		this.reimbursementMark = reimbursementMark;
		this.notes = notes;
	}

	public String getCode() {
		return code;
	}

	public String getName() {
		return name;
	}

	public String getCetegory() {
		return cetegory;
	}

	public String getReimbursementMark() {
		return reimbursementMark;
	}

	public String getNotes() {
		return notes;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setCetegory(String cetegory) {
		this.cetegory = cetegory;
	}

	public void setReimbursementMark(String reimbursementMark) {
		this.reimbursementMark = reimbursementMark;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	@Override
	public String toString() {
		return super.toString() + ",\"code\": \"" + code + "\",\"name\": \"" + name + "\",\"cetegory\": \"" + cetegory
				+ "\",\"reimbursementMark\": \"" + reimbursementMark + "\",\"notes\": \"" + notes + "\"";
	}
}
