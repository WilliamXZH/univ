package pers.william.composite.reference_Version_3;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Root extends Node {
	private List<Node> nodeList;
	public Root(){
		this.nodeList=new ArrayList<Node>();
	}
	
	@Override
	public Node AddSubNode(Node node) {
		nodeList.add(node);
		return this;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		return nodeList.remove(index);
	}

	@Override
	public void clearSubNode() {
		nodeList.clear();
	}

	@Override
	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

	@Override
	public void operation() {
		//do Root's operation
	}

}
