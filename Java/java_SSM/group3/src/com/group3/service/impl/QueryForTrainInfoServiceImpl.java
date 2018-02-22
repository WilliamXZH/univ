package com.group3.service.impl;

import java.sql.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.springframework.stereotype.Service;

import com.group3.mapper.QueryForTrainInfoMapper;
import com.group3.po.Train;
import com.group3.service.QueryForTrainInfoService;

@Service
public class QueryForTrainInfoServiceImpl implements QueryForTrainInfoService {
	@Resource
	QueryForTrainInfoMapper queryForTrainInfoMapper;
	/**
	 * 调用持久层查询车次信息
	 */
	@Override
	public Train queryForTrainInfo(Train train) {
		Train requiredTrain = queryForTrainInfoMapper.queryForTrainInfo(train);
		return requiredTrain;
	}
	public List<Train> queryAll(){
		List<Train> list = queryForTrainInfoMapper.queryAll();
		return list;
	}
}
