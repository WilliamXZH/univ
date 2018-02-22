package com.group3.mapper;

import com.group3.po.Time;

public interface TimeMapper {
	public Time selectArvAndLvTime(Integer trainId,Integer stationId);
	public Integer getDifferByTrainAndStation(Integer trainId,Integer departureId,Integer destinationId);
}
