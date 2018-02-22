package pers.william.util;

import java.util.List;

import pers.william.util.UserUtil;

public class UserUtil{

	public static Double getSimilarity(List<Double> list1, List<Double> list2) {
		
		Double avg1 = BaseOper.getAverage(list1);
		Double avg2 = BaseOper.getAverage(list2);
		
		Integer length = list1.size();
		Double dividend = new Double(0);
		Double divisor1 = new Double(0);
		Double divisor2 = new Double(0);
		
		for(int i=0;i<length;i++){
			double ra = list1.get(i);
			double rb = list2.get(i);
			
			dividend += (ra-avg1)*(rb-avg2);
			
			divisor1 += Math.pow(ra,2);
			divisor2 += Math.pow(rb, 2);
		}
		
		return dividend/(Math.sqrt(divisor1)*Math.sqrt(divisor2));
	}

}
