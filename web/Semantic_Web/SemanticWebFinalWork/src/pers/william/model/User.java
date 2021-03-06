package pers.william.model;

import java.util.ArrayList;
import java.util.List;

public class User {
	
	private Integer userid;
	private List<Item> ratings;
	
	private Double avg=0.0;
	
	public User(){
		super();
	}
	
	public User(Integer userid, List<Item> ratings) {
		super();
		this.userid = userid;
		this.ratings = ratings;
	}
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	public List<Item> getRatings() {
		return ratings;
	}
	public void setRatings(List<Item> ratings) {
		this.ratings = ratings;
	}
	
	public List<Double> toList(){
		List<Double> list = new ArrayList<>();
		
		for (Item item : ratings) {
			//list.add(e)
		}
	}
	
	public Double getAverage(){
		if(avg==0){
			int length = ratings.size();
			for(Item item:ratings){
				avg += item.getRating()/length;
			}
		}
		
		return avg;
	}
	
	public Double getSimilarity(User target) {
		
		Double avg1 = getAverage();
		Double avg2 = target.getAverage();
		
		Integer length1 = getRatings().size();
		Integer length2 = target.getRatings().size();
		Integer length = length1<length2?length1:length2;
		
		Double dividend = new Double(0);
		Double divisor1 = new Double(0);
		Double divisor2 = new Double(0);
		
		for(int i=0;i<length;i++){
			double ra = ratings.get(i).getRating();
			double rb = target.getRatings().get(i).getRating();
			
			dividend += (ra-avg1)*(rb-avg2);
			
			divisor1 += Math.pow(ra,2);
			divisor2 += Math.pow(rb, 2);
		}
		
		return dividend/(Math.sqrt(divisor1)*Math.sqrt(divisor2));
	}
}
