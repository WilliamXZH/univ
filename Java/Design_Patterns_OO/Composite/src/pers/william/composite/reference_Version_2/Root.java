package pers.william.composite.reference_Version_2;

import java.util.Iterator;
import java.util.List;

public class Root implements Node {

	private List<Node> nodeList;
	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

	public void operation() {

		//pre-operation here
		for(Node node:this){
			node.operation();
		}
		//post-operation here
	}

	public Node addSubNode(Node node) {
		nodeList.add(node);
		return this;
	}

	public Node removeSubNodeByIndex(int index) {	
		return nodeList.remove(index);
	}

	public void clearSubNodes() {
		nodeList.clear();
	}

}
