package net.librec.similarity;

import java.util.List;

/**
 * Bayesian Similarity
 * @author William (My Chinese name is XuZenghui)
 * 
 *
 */
public class BSSimilarity extends AbstractRecommenderSimilarity{

	
    /**
     * <b>The follow comments are just copy:</b><br/>
     * Calculate the similarity between thisList and thatList.
     *
     * @param thisList
     *            this list
     * @param thatList
     *            that list
     * @return similarity
     */
	@Override
	protected double getSimilarity(List<? extends Number> thisList, List<? extends Number> thatList) {
        if (thisList == null || thatList == null || thisList.size() < 1 || thatList.size() < 1 || thisList.size() != thatList.size()) {
            return Double.NaN;
        }
		
        
		// TODO Auto-generated method stub
		return 0;
	}
	
	
}
