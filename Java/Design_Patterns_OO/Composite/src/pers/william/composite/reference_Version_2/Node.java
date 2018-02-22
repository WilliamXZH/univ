package pers.william.composite.reference_Version_2;

public interface Node extends Iterable<Node> {
	public void operation();
	public Node addSubNode(Node node);
	public Node removeSubNodeByIndex(int index);
	public void clearSubNodes();
}

