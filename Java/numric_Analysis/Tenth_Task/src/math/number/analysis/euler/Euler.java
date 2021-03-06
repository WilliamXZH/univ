package math.number.analysis.euler;

/**
 * y'&nbsp;=&nbsp;4x/y-xy,&nbsp;0&lt;x&lt;=2<br/>
 * y(0)&nbsp;=&nbsp;0<br/>
 * <br/>
 * y(n+1)&nbsp;=&nbsp;y(n)+h(4x/y-xy)</br>
 * y(0)&nbsp;=&nbsp0
 */
public class Euler {

	private Double stepWith;
	private Double upperBound;
	private Double lowwerBound;
	private Double originalOfY;
	private Double originalOfX;

	public Euler(Double originalx, Double originaly, Double lowwer, Double upper){
		super();
		this.originalOfX = originalx;
		this.originalOfY = originaly;
		this.upperBound = upper;
		this.lowwerBound = lowwer;
	}
	
	
	public Double getOriginalOfX() {
		return originalOfX;
	}

	public void setOriginalOfX(Double originalOfX) {
		this.originalOfX = originalOfX;
	}

	public Double getStepWith() {
		return stepWith;
	}

	public void setStepWith(Double stepWith) {
		this.stepWith = stepWith;
	}

	public Double getUpperBound() {
		return upperBound;
	}


	public void setUpperBound(Double upperBound) {
		this.upperBound = upperBound;
	}


	public Double getLowwerBound() {
		return lowwerBound;
	}


	public void setLowwerBound(Double lowwerBound) {
		this.lowwerBound = lowwerBound;
	}


	public Double getOriginalOfY() {
		return originalOfY;
	}


	public void setOriginalOfY(Double originalOfY) {
		this.originalOfY = originalOfY;
	}

	private Double getNextY(Double x, Double y){
		if(y==0){
			return stepWith*(4-x*y);
		}else{
			return y+stepWith*(4*x/y-x*y);
		}
	}
	private Double getYx(Double x){
		return Math.sqrt(4+5*Math.pow(Math.E, -Math.pow(x, 2)));
	}
	
	public void start(){
		Double x = originalOfX;
		Double y =originalOfY;
		
		String total = "";
		
		for(;x<=upperBound;x+=stepWith){
			Double yx = getYx(x);
			Result result = new Result(x, y, yx, yx-y);
			y = getNextY(x, y);
			
			total += result.toString();
		}
		
		System.out.println(total);
	}
}
