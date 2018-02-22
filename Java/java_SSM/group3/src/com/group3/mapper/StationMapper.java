package com.group3.mapper;

import com.group3.po.Station;
import com.group3.vo.StationVO;

public interface StationMapper {

	public Station selectStationByName(String name);
	public Station selectStationById(Integer id);
	public StationVO selectStationByEntireRoute(Integer trainId);
	
}
