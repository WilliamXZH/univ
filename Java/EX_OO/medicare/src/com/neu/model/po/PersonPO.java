package com.neu.model.po;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.neu.model.vo.PersonVO;

public class PersonPO {

	/*
	 * ����ID,֤������,֤�����,����,�Ա�,����,��������,�μӹ�������,����������,������״̬,��������,�������ڵ�,�Ļ��̶�,������ò,�������
	 * ,�ù���ʽ,רҵ����ְ��,����ְҵ�ʸ�ȼ������˼����ȼ���,����״��,����ְ��,��ע,��λ����,ҽ����Ա���,����״��,��ģ��־,�ɲ���־,
	 * ����Ա��־,�ڱ��־,�������,����ҵ��־,ũ�񹤱�־,������־,��ת��Ա��־,�籣���ţ�ϵͳ�Զ����ɣ�������ҽ�ƻ�������
	 */
	private Integer personId;
	private Integer certificateType;
	private String credentialNumber;
	private String compellation;
	private String gender;
	private Integer nation;
	private Date dateOfBirth;
	private Date dateOfEnterTheService;
	private Date dateOfRetire;
	private Integer retireStatus;
	private Integer hoursehold;
	private String placeOfHoursehold;
	private Integer degreeOfEducation;
	private Integer politicalStatus;
	private Integer individualStatus;//�������
	private Integer serviceMode;
	private Integer professionalTechnicalPosition;
	private Integer nationalProfessionQualificationDegree;
	private Integer maritalStatus;
	private Integer administrativePost;
	private String remarks;
	private Integer unitType;
	private Integer medicalPersonnelCategory;
	private Integer healthCondition;
	private Integer modelWorkMark;
	private Integer cadreMark;
	private Integer civilianMark;//����Ա��־
	private Integer regularMark;
	private Integer residentClusters;// ��������
	private Integer flexibleEmployment;
	private Integer migrantWrokerMark;// ũ�񹤱�־
	private Integer masterMark;
	private Integer militaryPersonnelMark;
	private String socialSecurityNumber;
	private String medicalInstitutionCode;

	public Integer getPersonId() {
		return personId;
	}

	public void setPersonId(Integer personId) {
		this.personId = personId;
	}

	public Integer getCertificateType() {
		return certificateType;
	}

	public void setCertificateType(Integer certificateType) {
		this.certificateType = certificateType;
	}

	public String getCredentialNumber() {
		return credentialNumber;
	}

	public void setCredentialNumber(String credentialNumber) {
		this.credentialNumber = credentialNumber;
	}

	public String getCompellation() {
		return compellation;
	}

	public void setCompellation(String compellation) {
		this.compellation = compellation;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public Integer getNation() {
		return nation;
	}

	public void setNation(Integer nation) {
		this.nation = nation;
	}

	public Date getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(Date dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public Date getDateOfEnterTheService() {
		return dateOfEnterTheService;
	}

	public void setDateOfEnterTheService(Date dateOfEnterTheService) {
		this.dateOfEnterTheService = dateOfEnterTheService;
	}

	public Date getDateOfRetire() {
		return dateOfRetire;
	}

	public void setDateOfRetire(Date dateOfRetire) {
		this.dateOfRetire = dateOfRetire;
	}

	public Integer getRetireStatus() {
		return retireStatus;
	}

	public void setRetireStatus(Integer retireStatus) {
		this.retireStatus = retireStatus;
	}

	public Integer getHoursehold() {
		return hoursehold;
	}

	public void setHoursehold(Integer hoursehold) {
		this.hoursehold = hoursehold;
	}

	public String getPlaceOfHoursehold() {
		return placeOfHoursehold;
	}

	public void setPlaceOfHoursehold(String placeOfHoursehold) {
		this.placeOfHoursehold = placeOfHoursehold;
	}

	public Integer getDegreeOfEducation() {
		return degreeOfEducation;
	}

	public void setDegreeOfEducation(Integer degreeOfEducation) {
		this.degreeOfEducation = degreeOfEducation;
	}

	public Integer getPoliticalStatus() {
		return politicalStatus;
	}

	public void setPoliticalStatus(Integer politicalStatus) {
		this.politicalStatus = politicalStatus;
	}

	public Integer getIndividualStatus() {
		return individualStatus;
	}

	public void setIndividualStatus(Integer individualStatus) {
		this.individualStatus = individualStatus;
	}

	public Integer getServiceMode() {
		return serviceMode;
	}

	public void setServiceMode(Integer serviceMode) {
		this.serviceMode = serviceMode;
	}

	public Integer getProfessionalTechnicalPosition() {
		return professionalTechnicalPosition;
	}

	public void setProfessionalTechnicalPosition(Integer professionalTechnicalPosition) {
		this.professionalTechnicalPosition = professionalTechnicalPosition;
	}

	public Integer getNationalProfessionQualificationDegree() {
		return nationalProfessionQualificationDegree;
	}

	public void setNationalProfessionQualificationDegree(Integer nationalProfessionQualificationDegree) {
		this.nationalProfessionQualificationDegree = nationalProfessionQualificationDegree;
	}

	public Integer getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(Integer maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public Integer getAdministrativePost() {
		return administrativePost;
	}

	public void setAdministrativePost(Integer administrativePost) {
		this.administrativePost = administrativePost;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public Integer getUnitType() {
		return unitType;
	}

	public void setUnitType(Integer unitType) {
		this.unitType = unitType;
	}

	public Integer getMedicalPersonnelCategory() {
		return medicalPersonnelCategory;
	}

	public void setMedicalPersonnelCategory(Integer medicalPersonnelCategory) {
		this.medicalPersonnelCategory = medicalPersonnelCategory;
	}

	public Integer getHealthCondition() {
		return healthCondition;
	}

	public void setHealthCondition(Integer healthCondition) {
		this.healthCondition = healthCondition;
	}

	public Integer getModelWorkMark() {
		return modelWorkMark;
	}

	public void setModelWorkMark(Integer modelWorkMark) {
		this.modelWorkMark = modelWorkMark;
	}

	public Integer getCadreMark() {
		return cadreMark;
	}

	public void setCadreMark(Integer cadreMark) {
		this.cadreMark = cadreMark;
	}

	public Integer getCivilianMark() {
		return civilianMark;
	}

	public void setCivilianMark(Integer civilianMark) {
		this.civilianMark = civilianMark;
	}

	public Integer getRegularMark() {
		return regularMark;
	}

	public void setRegularMark(Integer regularMark) {
		this.regularMark = regularMark;
	}

	public Integer getResidentClusters() {
		return residentClusters;
	}

	public void setResidentClusters(Integer residentClusters) {
		this.residentClusters = residentClusters;
	}

	public Integer getFlexibleEmployment() {
		return flexibleEmployment;
	}

	public void setFlexibleEmployment(Integer flexibleEmployment) {
		this.flexibleEmployment = flexibleEmployment;
	}

	public Integer getMigrantWrokerMark() {
		return migrantWrokerMark;
	}

	public void setMigrantWrokerMark(Integer migrantWrokerMark) {
		this.migrantWrokerMark = migrantWrokerMark;
	}

	public Integer getMasterMark() {
		return masterMark;
	}

	public void setMasterMark(Integer masterMark) {
		this.masterMark = masterMark;
	}

	public Integer getMilitaryPersonnelMark() {
		return militaryPersonnelMark;
	}

	public void setMilitaryPersonnelMark(Integer militaryPersonnelMark) {
		this.militaryPersonnelMark = militaryPersonnelMark;
	}

	public String getSocialSecurityNumber() {
		return socialSecurityNumber;
	}

	public void setSocialSecurityNumber(String socialSecurityNumber) {
		this.socialSecurityNumber = socialSecurityNumber;
	}

	public String getMedicalInstitutionCode() {
		return medicalInstitutionCode;
	}

	public void setMedicalInstitutionCode(String medicalInstitutionCode) {
		this.medicalInstitutionCode = medicalInstitutionCode;
	}

	public PersonPO() {
		super();
	}

	public PersonPO(Integer personId, Integer certificateType, String credentialNumber, String compellation,
			String gender, Integer nation, Date dateOfBirth, Date dateOfEnterTheService, Date dateOfRetire,
			Integer retireStatus, Integer hoursehold, String placeOfHoursehold, Integer degreeOfEducation,
			Integer politicalStatus, Integer individualStatus, Integer serviceMode,
			Integer professionalTechnicalPosition, Integer nationalProfessionQualificationDegree, Integer maritalStatus,
			Integer administrativePost, String remarks, Integer unitType, Integer medicalPersonnelCategory,
			Integer healthCondition, Integer modelWorkMark, Integer cadreMark, Integer civilianMark,
			Integer regularMark, Integer residentClusters, Integer flexibleEmployment, Integer migrantWrokerMark,
			Integer masterMark, Integer militaryPersonnelMark, String socialSecurityNumber,
			String medicalInstitutionCode) {
		super();
		this.personId = personId;
		this.certificateType = certificateType;
		this.credentialNumber = credentialNumber;
		this.compellation = compellation;
		this.gender = gender;
		this.nation = nation;
		this.dateOfBirth = dateOfBirth;
		this.dateOfEnterTheService = dateOfEnterTheService;
		this.dateOfRetire = dateOfRetire;
		this.retireStatus = retireStatus;
		this.hoursehold = hoursehold;
		this.placeOfHoursehold = placeOfHoursehold;
		this.degreeOfEducation = degreeOfEducation;
		this.politicalStatus = politicalStatus;
		this.individualStatus = individualStatus;
		this.serviceMode = serviceMode;
		this.professionalTechnicalPosition = professionalTechnicalPosition;
		this.nationalProfessionQualificationDegree = nationalProfessionQualificationDegree;
		this.maritalStatus = maritalStatus;
		this.administrativePost = administrativePost;
		this.remarks = remarks;
		this.unitType = unitType;
		this.medicalPersonnelCategory = medicalPersonnelCategory;
		this.healthCondition = healthCondition;
		this.modelWorkMark = modelWorkMark;
		this.cadreMark = cadreMark;
		this.civilianMark = civilianMark;
		this.regularMark = regularMark;
		this.residentClusters = residentClusters;
		this.flexibleEmployment = flexibleEmployment;
		this.migrantWrokerMark = migrantWrokerMark;
		this.masterMark = masterMark;
		this.militaryPersonnelMark = militaryPersonnelMark;
		this.socialSecurityNumber = socialSecurityNumber;
		this.medicalInstitutionCode = medicalInstitutionCode;
	}
	
	public PersonPO(PersonVO person){
		super();
		
	}
	
	public PersonPO(String str){
		super();
		String []params = str.split(" ");
		
		this.personId = Integer.parseInt(params[0]);
		this.certificateType = Integer.parseInt(params[1]);
		this.credentialNumber = params[2];
		this.compellation = params[3];
		this.gender = params[4];
		this.nation = Integer.parseInt(params[5]);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
		
		try {
			this.dateOfBirth = sdf.parse(params[6]);
			this.dateOfEnterTheService = sdf.parse(params[7]);
			this.dateOfRetire = sdf.parse(params[8]);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		this.retireStatus = Integer.parseInt(params[9]);
		this.hoursehold = Integer.parseInt(params[10]);
		this.placeOfHoursehold = params[11];
		this.degreeOfEducation = Integer.parseInt(params[12]);
		this.politicalStatus = Integer.parseInt(params[13]);
		this.individualStatus = Integer.parseInt(params[14]);
		this.serviceMode = Integer.parseInt(params[15]);
		this.professionalTechnicalPosition = Integer.parseInt(params[16]);
		this.nationalProfessionQualificationDegree = Integer.parseInt(params[17]);
		this.maritalStatus = Integer.parseInt(params[18]);
		this.administrativePost = Integer.parseInt(params[19]);
		this.remarks = params[20];
		this.unitType = Integer.parseInt(params[21]);
		this.medicalPersonnelCategory = Integer.parseInt(params[22]);
		this.healthCondition = Integer.parseInt(params[23]);
		this.modelWorkMark = Integer.parseInt(params[24]);
		this.cadreMark = Integer.parseInt(params[25]);
		this.civilianMark = Integer.parseInt(params[26]);
		this.regularMark = Integer.parseInt(params[27]);
		this.residentClusters = Integer.parseInt(params[28]);
		this.flexibleEmployment = Integer.parseInt(params[29]);
		this.migrantWrokerMark = Integer.parseInt(params[30]);
		this.masterMark = Integer.parseInt(params[31]);
		this.militaryPersonnelMark = Integer.parseInt(params[32]);
		this.socialSecurityNumber = params[33];
		this.medicalInstitutionCode = params[34];
	}

	@Override
	public String toString() {
		return "PersonPO [personId=" + personId + ", certificateType=" + certificateType + ", credentialNumber="
				+ credentialNumber + ", compellation=" + compellation + ", gender=" + gender + ", nation=" + nation
				+ ", dateOfBirth=" + dateOfBirth + ", dateOfEnterTheService=" + dateOfEnterTheService
				+ ", dateOfRetire=" + dateOfRetire + ", retireStatus=" + retireStatus + ", hoursehold=" + hoursehold
				+ ", placeOfHoursehold=" + placeOfHoursehold + ", degreeOfEducation=" + degreeOfEducation
				+ ", politicalStatus=" + politicalStatus + ", individualStatus=" + individualStatus + ", serviceMode="
				+ serviceMode + ", professionalTechnicalPosition=" + professionalTechnicalPosition
				+ ", nationalProfessionQualificationDegree=" + nationalProfessionQualificationDegree
				+ ", maritalStatus=" + maritalStatus + ", administrativePost=" + administrativePost + ", remarks="
				+ remarks + ", unitType=" + unitType + ", medicalPersonnelCategory=" + medicalPersonnelCategory
				+ ", healthCondition=" + healthCondition + ", modelWorkMark=" + modelWorkMark + ", cadreMark="
				+ cadreMark + ", civilianMark=" + civilianMark + ", regularMark=" + regularMark + ", residentClusters="
				+ residentClusters + ", flexibleEmployment=" + flexibleEmployment + ", migrantWrokerMark="
				+ migrantWrokerMark + ", masterMark=" + masterMark + ", MilitaryPersonnelMark=" + militaryPersonnelMark
				+ ", socialSecurityNumber=" + socialSecurityNumber + ", medicalInstitutionCode="
				+ medicalInstitutionCode + "]";
	}
	
	public String toItem(){
		return personId + " " + certificateType + " "
				+ credentialNumber + " " + compellation + " " + gender + " " + nation
				+ " " + dateOfBirth + " " + dateOfEnterTheService
				+ " " + dateOfRetire + " " + retireStatus + " " + hoursehold
				+ " " + placeOfHoursehold + " " + degreeOfEducation
				+ " " + politicalStatus + " " + individualStatus + " "
				+ serviceMode + " " + professionalTechnicalPosition
				+ " " + nationalProfessionQualificationDegree
				+ " " + maritalStatus + " " + administrativePost + " "
				+ remarks + " " + unitType + " " + medicalPersonnelCategory
				+ " " + healthCondition + " " + modelWorkMark + " "
				+ cadreMark + " " + civilianMark + " " + regularMark + " "
				+ residentClusters + " " + flexibleEmployment + " "
				+ migrantWrokerMark + " " + masterMark + " " + militaryPersonnelMark
				+ " " + socialSecurityNumber + " "
				+ medicalInstitutionCode+"\n";
	}

}
