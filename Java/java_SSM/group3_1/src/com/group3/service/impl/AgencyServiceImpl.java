package com.group3.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.AgencyMapper;
import com.group3.po.Agency;
import com.group3.service.AgencyService;

@Service
public class AgencyServiceImpl implements AgencyService {
	
	@Resource
	AgencyMapper agencyMapper;
	
	@Override
	public List<Agency> agencySelect(String address) {
		List<Agency> list = agencyMapper.agencySelect(address);
		return list;
	}

}
