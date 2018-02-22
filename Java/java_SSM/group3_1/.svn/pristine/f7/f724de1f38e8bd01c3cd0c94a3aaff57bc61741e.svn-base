package com.group3.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.TimeMapper;
import com.group3.po.Time;
import com.group3.service.TimeService;
@Service
public class TimeServiceImpl implements TimeService {
	@Resource
	TimeMapper timeMapper;
	
	@Override
	public Time queryArvAndLvTime(int trainId,int stationId) {
		Time requiredTime = timeMapper.selectArvAndLvTime(trainId, stationId);
		System.out.println("param:trainId:"+trainId);
		System.out.println("&stationId:"+stationId);
		System.out.println("service:"+requiredTime);
		return requiredTime;
	}

}
