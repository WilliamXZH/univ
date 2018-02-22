package base;

public class MedicalInstitution{

	private String levle;
	private String category;
	private String postCode;
	private String legalRepresentativeName;
	private String legalRepresentativePhone;
	private String contactName;
	private String contactNumber;
	private String address;
	private String notes;
	private String name;
	private String code;

	public MedicalInstitution(String name, String code,String levle, String category, String postCode,
			String legalRepresentativeName, String legalRepresentativePhone, String contactName, String contactNumber,
			String address, String notes) {
		this.name=name;
		this.code=code;
		this.levle = levle;
		this.category = category;
		this.postCode = postCode;
		this.legalRepresentativeName = legalRepresentativeName;
		this.legalRepresentativePhone = legalRepresentativePhone;
		this.contactName = contactName;
		this.contactNumber = contactNumber;
		this.address = address;
		this.notes = notes;
	}

	public String getName() {
		return name;
	}

	public String getCode() {
		return code;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Override
	public String toString() {
		return "\"levle\": \"" + levle + "\",\"category\": \"" + category + "\",\"postCode\": \"" + postCode
				+ "\",\"legalRepresentativeName\": \"" + legalRepresentativeName + "\",\"legalRepresentativePhone\": \""
				+ legalRepresentativePhone + "\",\"contactName\": \"" + contactName + "\",\"contactNumber\": \""
				+ contactNumber + "\",\"address\": \"" + address + "\",\"notes\": \"" + notes + "\",\"name\": \"" + name
				+ "\",\"code\": \"" + code + "\"";
	}

	public String getLevle() {
		return levle;
	}

	public String getCategory() {
		return category;
	}

	public String getPostCode() {
		return postCode;
	}

	public String getLegalRepresentativeName() {
		return legalRepresentativeName;
	}

	public String getLegalRepresentativePhone() {
		return legalRepresentativePhone;
	}

	public String getContactName() {
		return contactName;
	}

	public String getContactNumber() {
		return contactNumber;
	}

	public String getAddress() {
		return address;
	}

	public String getNotes() {
		return notes;
	}

	public void setLevle(String levle) {
		this.levle = levle;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public void setLegalRepresentativeName(String legalRepresentativeName) {
		this.legalRepresentativeName = legalRepresentativeName;
	}

	public void setLegalRepresentativePhone(String legalRepresentativePhone) {
		this.legalRepresentativePhone = legalRepresentativePhone;
	}

	public void setContactName(String contactName) {
		this.contactName = contactName;
	}

	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

}
