package com.group3.mapper;

import java.util.List;

import com.group3.po.Train;
import com.group3.vo.TrainForBL;

public interface QueryForTrainInfoMapper {
	public Train queryForTrainInfo(Train train);
	public List<Train> queryAll();
}
