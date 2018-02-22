package pers.william.similarity;

import java.util.List;

/**
 * Euclidean Distance
 * @author Administrator
 *
 */
public class EDSimilarity {
	
	private static double getEuclideanDistance(List<Double> list1,List<Double> list2){
		
		double res = 0;
		int length = list1.size();
		
		for(int i=0;i<length;i++){
			double x = list1.get(i);
			double y = list2.get(i);
			res += Math.pow(x-y, 2);
		}
		
		return Math.sqrt(res);
	}
	
	public static double getSimilarity(List<Double> list1,List<Double> list2){
		
		int length1 = list1.size();
		int length2 = list2.size();
		
		if(length1!=length2){
			return 0;
		}
		
		double dividend = 1;
		double divisor = getEuclideanDistance(list1,list2)+1;
		
		return dividend/divisor;
	}
}
