package pers.william.composite.thirdexper_2;

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
	public void setValue(String value){
		this.value=value;
	}
	public String getValue(){
		return this.value;
	}
	public Node getParentNode(){
		return parentNode;
	}
	
	public abstract Node addSubNode(Node node);
	public abstract Node getSubNodeByIndex(int index);
	public abstract Node removeSubNodeByIndex(int index);
	public abstract void clearSubNodes();
	public abstract Iterator<Node> iterator();
	public abstract void operation();
	
}
