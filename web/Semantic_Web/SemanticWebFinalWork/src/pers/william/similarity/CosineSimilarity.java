package pers.william.similarity;

import java.util.List;

public class CosineSimilarity {
	
	public static double getSimilarity(List<Double> list1, List<Double> list2){
		
		int length1 = list1.size();
		int length2 = list2.size();
		
		if(length1!=length2){
			return 0;
		}
		
		double dividend = 0;
		double divisor1 = 0;
		double divisor2 = 0;
		
		
		for(int i=0;i<length1;i++){
			double x = list1.get(i);
			double y = list2.get(i);
			
			dividend += x*y;
			divisor1 += Math.pow(x, 2);
			divisor2 += Math.pow(y, 2);
		}
		
		return dividend/(Math.sqrt(divisor1*divisor2));
	}
}
