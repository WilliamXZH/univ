package pers.william.composite.thirdexper;

import java.util.Iterator;

public abstract class Node implements Iterable<Node> {
	protected String value="Level";
	protected Node parentNode;
	
	protected void addParentNode(Node parentNode){
		this.parentNode=parentNode;
	}
	protected void removeParentNode(){
		parentNode=null;
	}
	
	protected void setValue(String value){
		this.value=value;
	}
	protected String getValue(){
		return value;
	}
	
	public void operation(int currentDepth){
		for(int iter=0;iter<currentDepth;iter++)
			System.out.print("\t");
		System.out.println(this.value);
	}
	
	public abstract void clearSubNode();
	public abstract Node addSubNode(Node node);
	public abstract Node removeSubNodeByIndex(int index);
	public abstract Iterator<Node> iterator();

}
