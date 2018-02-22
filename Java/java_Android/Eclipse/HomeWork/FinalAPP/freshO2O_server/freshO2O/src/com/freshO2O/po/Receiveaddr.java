package com.freshO2O.po;

/**
 * Receiveaddr entity. @author MyEclipse Persistence Tools
 */

public class Receiveaddr implements java.io.Serializable {

	// Fields

	private Integer id;
	private String username;
	private String phone;
	private String address;
	private String account;
	private String defaultaddr;

	// Constructors

	/** default constructor */
	public Receiveaddr() {
	}

	/** full constructor */
	public Receiveaddr(String username, String phone, String address) {
		this.username = username;
		this.phone = phone;
		this.address = address;
	}

	// Property accessors

	public String getDefaultaddr() {
		return defaultaddr;
	}

	public void setDefaultaddr(String defaultaddr) {
		this.defaultaddr = defaultaddr;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

}