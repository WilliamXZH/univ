package com.group3.mapper;

import java.util.List;
import com.group3.po.SeatInfo;
import com.group3.po.SeatQueryCondition;

public interface SeatMapper {
	public List<SeatInfo> allocSeat(SeatQueryCondition condition);
	public Integer[] selectRouteIds(SeatQueryCondition condition);
	public Integer selectSeatId(Integer carriageId,String num,Integer routeId);
	public Integer updateSeatStatus(Integer id,Integer status);
}
