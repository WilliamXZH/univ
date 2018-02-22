package com.sand.vo;

public class MyFinal {
	String years;
	String mouth;
	int vaule;

	public String getYears() {
		return years;
	}

	public void setYears(String years) {
		this.years = years;
	}

	public String getMouth() {
		return mouth;
	}

	public void setMouth(String mouth) {
		this.mouth = mouth;
	}

	public MyFinal() {
		super();
	}

	public int getVaule() {
		return vaule;
	}

	public void setVaule(int vaule) {
		this.vaule = vaule;
	}

	public MyFinal(String years, String mouth, int vaule) {
		super();
		this.years = years;
		this.mouth = mouth;
		this.vaule = vaule;
	}

}
