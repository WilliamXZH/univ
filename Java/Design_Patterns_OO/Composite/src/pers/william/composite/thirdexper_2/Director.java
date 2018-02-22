package pers.william.composite.thirdexper_2;

public class Director {
	private Builder builder;
	public Director(Builder builder){
		this.builder=builder;
	}
	
	public Node construct(int totalDepth){
		return builder.build(totalDepth);
	}
}
