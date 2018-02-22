package pers.william.composite.reference_Version_6;

import java.util.Iterator;

public interface Node extends Iterable<Node> {
	public boolean isRoot();
	public void addParentNode(Node parentNode);
	public void removeParentNode();
	public Node getParentNode();
	public Node addSubNode(Node node);
	public Node removeSubNodeByIndex(int index);
	public void clearSubNodes();
	public Iterator<Node> iterator();
	public void operation();
}
