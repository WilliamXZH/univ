package com.sand.vo;


public class Out {
	String years;
	int jan;
	int feb;
	int mar;
	int apr;
	int may;
	int jun;
	int jul;
	int aug;
	int sept;
	int oct;
	int nov;
	int dec;
	public String getYears() {
		return years;
	}
	public void setYears(String years) {
		this.years = years;
	}
	public int getJan() {
		return jan;
	}
	public void setJan(int jan) {
		this.jan = jan;
	}
	public int getFeb() {
		return feb;
	}
	public void setFeb(int feb) {
		this.feb = feb;
	}
	public int getMar() {
		return mar;
	}
	public void setMar(int mar) {
		this.mar = mar;
	}
	public int getApr() {
		return apr;
	}
	public void setApr(int apr) {
		this.apr = apr;
	}
	public int getMay() {
		return may;
	}
	public void setMay(int may) {
		this.may = may;
	}
	public int getJun() {
		return jun;
	}
	public void setJun(int jun) {
		this.jun = jun;
	}
	public int getJul() {
		return jul;
	}
	public void setJul(int jul) {
		this.jul = jul;
	}
	public int getAug() {
		return aug;
	}
	public void setAug(int aug) {
		this.aug = aug;
	}
	public int getSept() {
		return sept;
	}
	public void setSept(int sept) {
		this.sept = sept;
	}
	public int getOct() {
		return oct;
	}
	public void setOct(int oct) {
		this.oct = oct;
	}
	public int getNov() {
		return nov;
	}
	public void setNov(int nov) {
		this.nov = nov;
	}
	public int getDec() {
		return dec;
	}
	public void setDec(int dec) {
		this.dec = dec;
	}
	public Out(String years, int jan, int feb, int mar, int apr, int may, int jun, int jul, int aug, int sept, int oct,
			int nov, int dec) {
		super();
		this.years = years;
		this.jan = jan;
		this.feb = feb;
		this.mar = mar;
		this.apr = apr;
		this.may = may;
		this.jun = jun;
		this.jul = jul;
		this.aug = aug;
		this.sept = sept;
		this.oct = oct;
		this.nov = nov;
		this.dec = dec;
	}
	@Override
	public String toString() {
		return "Out [years=" + years + ", jan=" + jan + ", feb=" + feb + ", mar=" + mar + ", apr=" + apr + ", may="
				+ may + ", jun=" + jun + ", jul=" + jul + ", aug=" + aug + ", sept=" + sept + ", oct=" + oct + ", nov="
				+ nov + ", dec=" + dec + "]";
	}
	
	
}

