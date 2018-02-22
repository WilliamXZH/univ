package com.group3.po;

public class TwoStringCondition {

	private String c1;
	private String c2;

	public TwoStringCondition() {
		super();
	}

	public TwoStringCondition(String c1, String c2) {
		super();
		this.c1 = c1;
		this.c2 = c2;
	}

	public String getC1() {
		return c1;
	}

	public void setC1(String c1) {
		this.c1 = c1;
	}

	public String getC2() {
		return c2;
	}

	public void setC2(String c2) {
		this.c2 = c2;
	}

	@Override
	public String toString() {
		return "TwoStringCondition [c1=" + c1 + ", c2=" + c2 + "]";
	}

}
