package com.example.sqlite;

public class Vendor
{
	int id;
	String VendorName;
	String address;
	String tel;

	public Vendor()
	{}

	public Vendor(String VendorName, String address, String tel)
	{
		this.VendorName = VendorName;
		this.address = address;
		this.tel = tel;
	}

	public int getId()
	{
		return id;
	}

	public void setId(int id)
	{
		this.id = id;
	}

	public String getVendorName()
	{
		return VendorName;
	}

	public void setVendorName(String vendorName)
	{
		VendorName = vendorName;
	}

	public String getAddress()
	{
		return address;
	}

	public void setAddress(String address)
	{
		this.address = address;
	}

	public String getTel()
	{
		return tel;
	}

	public void setTel(String tel)
	{
		this.tel = tel;
	}
}
