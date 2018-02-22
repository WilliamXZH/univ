package pers.william.composite.reference_Version_5;

import java.util.Iterator;

public interface Node extends Iterable<Node> {
	public boolean isLeaf();
	
	public void addParentNode(Node parentNode);
	public void removeParentNode();
	
	public Node getParentNode();
	public Node addSubNode(Node node);
	public Node removeSubNodeByIndex(int index);
	public void clearSubNode();
	
	public Iterator<Node> iterator();
	public void operation();
}
