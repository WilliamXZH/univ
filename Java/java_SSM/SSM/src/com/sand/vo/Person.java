package com.sand.vo;

public class Person {
	String age;
	String sex;
	int value;
	public String getAge() {
		return age;
	}
	public void setAge(String age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public int getValue() {
		return value;
	}
	public void setValue(int value) {
		this.value = value;
	}
	public Person(String age, String sex, int value) {
		super();
		this.age = age;
		this.sex = sex;
		this.value = value;
	}
	@Override
	public String toString() {
		return "Person [age=" + age + ", sex=" + sex + ", value=" + value + "]";
	}
	

}
