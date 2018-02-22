package com.group3.service;

import java.util.List;

import com.group3.po.Agency;

public interface AgencyService {
	
	public List<Agency> agencySelect(String address);

}
