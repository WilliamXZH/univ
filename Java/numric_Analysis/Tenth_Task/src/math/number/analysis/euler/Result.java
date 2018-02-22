package math.number.analysis.euler;

public class Result {
	
	Double independentVariable;
	Double dependentVariable;
	Double accurateResult;
	Double dValue;
	
	public Result(Double independent, Double dependent, 
			Double accurate, Double dvalue){
		super();
		this.independentVariable = independent;
		this.dependentVariable = dependent;
		this.accurateResult = accurate;
		this.dValue = dvalue;
	}
	
	public Double getIndependentVariable() {
		return independentVariable;
	}
	public void setIndependentVariable(Double independentVariable) {
		this.independentVariable = independentVariable;
	}
	public Double getDependentVariable() {
		return dependentVariable;
	}
	public void setDependentVariable(Double dependentVariable) {
		this.dependentVariable = dependentVariable;
	}
	public Double getAccurateResult() {
		return accurateResult;
	}
	public void setAccurateResult(Double accurateResult) {
		this.accurateResult = accurateResult;
	}
	public Double getdValue() {
		return dValue;
	}
	public void setdValue(Double dValue) {
		this.dValue = dValue;
	}
	
	public String toString(){
		return independentVariable +"\t" + dependentVariable + "\t"
				+ accurateResult + "\t" + dValue +"\n";
	}
}
