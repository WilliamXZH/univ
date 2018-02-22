package com.group3.vo;

import com.group3.po.Station;
import com.group3.util.TimeDiffer;
public class resultOfTrainQuery {
	Station station;
	String arvTime;
	String lvTime;
	String timeDiffer;
	public resultOfTrainQuery() {
		super();
	}
	public resultOfTrainQuery(Station station, String arvTime, String lvTime) {
		super();
		this.station = station;
		this.arvTime = arvTime;
		this.lvTime = lvTime;
		this.timeDiffer = TimeDiffer.timeDiff(arvTime, lvTime);
	}

	public Station getStation() {
		return station;
	}

	public void setStation(Station station) {
		this.station = station;
	}

	public String getArvTime() {
		return arvTime;
	}

	public void setArvTime(String arvTime) {
		this.arvTime = arvTime;
	}

	public String getLvTime() {
		return lvTime;
	}

	public void setLvTime(String lvTime) {
		this.lvTime = lvTime;
	}
	@Override
	public String toString() {
		return "resultOfTrainQuery [station=" + station + ", arvTime=" + arvTime + ", lvTime=" + lvTime + ", timeDiffer=" + timeDiffer + "]";
	}
	public String getTimeDiffer() {
		return timeDiffer;
	}
	public void setTimeDiffer(String timeDiffer) {
		this.timeDiffer = timeDiffer;
	}
	
}