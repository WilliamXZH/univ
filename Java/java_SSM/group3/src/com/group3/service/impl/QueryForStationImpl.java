package com.group3.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.group3.mapper.StationMapper;
import com.group3.po.Station;
import com.group3.service.QueryForStationService;
@Service
public class QueryForStationImpl implements QueryForStationService {
	@Resource
	StationMapper stationMapper;
	@Override
	public Station queryForStation(int id) {
		Station station = stationMapper.selectStationById(id);
		return station;
	}

}
