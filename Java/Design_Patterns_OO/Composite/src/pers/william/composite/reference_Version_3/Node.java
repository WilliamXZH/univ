package pers.william.composite.reference_Version_3;

import java.util.Iterator;

public abstract class Node implements Iterable<Node> {
	protected Node parentNode;
	public void addParentNode(Node parentNode){
		this.parentNode=parentNode;
	}
	public Node getParentNode(){
		return parentNode;
	}
	public void removeParentNode(){
		parentNode=null;
	}
	
	public abstract Node AddSubNode(Node node);
	public abstract Node removeSubNodeByIndex(int index);
	public abstract void clearSubNode();
	public abstract Iterator<Node> iterator();
	public abstract void operation();

}
