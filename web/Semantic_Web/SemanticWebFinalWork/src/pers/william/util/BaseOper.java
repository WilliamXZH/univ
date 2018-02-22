package pers.william.util;

import java.util.List;

public class BaseOper{

	public static Double getAverage(List<Double> list) {

		Integer length = list.size();
		Double avg = new Double(0);
		
		for(Double d:list){
			avg += d/length;
		}
		return avg;
	}

}
