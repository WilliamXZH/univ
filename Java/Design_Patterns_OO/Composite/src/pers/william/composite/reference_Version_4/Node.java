package pers.william.composite.reference_Version_4;

import java.util.Iterator;

public abstract class Node implements Iterable<Node> {
	protected Node parentNode;
	protected void addParentNode(Node parentNode){
		this.parentNode=parentNode;
	}
	protected void removeParentNode(){
		parentNode=null;
	}
	public Node getParentNode(){
		return parentNode;
	}
	
	public abstract Node addSubNode(Node node);
	public abstract Node removeSubNodeByIndex(int index);
	public abstract void clearSubNodes();
	public abstract Iterator<Node> iterator();
	public abstract void operation();
	
}
