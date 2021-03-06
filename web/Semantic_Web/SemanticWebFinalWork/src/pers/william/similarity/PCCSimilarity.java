package pers.william.similarity;

import java.util.List;

import pers.william.util.BaseOper;

/**
 * Pearson Correlation Coefficient
 * 
 * @author william
 * 
 *
 */
public class PCCSimilarity {
	
	public static double getSimilarity(List<Double> list1,List<Double> list2){
		
		int length1 = list1.size();
		int length2 = list2.size();
		
		if(length1!=length2){
			return 0;
		}
		
		double dividendLeft = 0;
		double dividendRight = 0;
		double divisorLeft1 = 0;
		double divisorLeft2 = 0;
		double divisorRight1 = 0;
		double divisorRight2 = 0;
		
		for(int i=0;i<length1;i++){
			double x = list1.get(i);
			double y = list2.get(i);
			
			dividendLeft += x*y;
			
			divisorLeft1 += Math.pow(x, 2);
			divisorLeft2 += x;
			
			divisorRight1 += Math.pow(y, 2);
			divisorRight2 += y;
		}
		dividendRight += length1 * BaseOper.getAverage(list1)*BaseOper.getAverage(list2);
		
		double dividend = (dividendLeft - dividendRight)/length1;
		
		double divisor = Math.sqrt(length1*divisorLeft1 - Math.pow(divisorLeft2, 2))
				*Math.sqrt(length1*divisorRight1 - Math.pow(divisorRight2, 2));
		
		return dividend/divisor;
	}
}
