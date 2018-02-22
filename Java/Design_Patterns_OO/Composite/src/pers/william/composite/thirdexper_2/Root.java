package pers.william.composite.thirdexper_2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Root extends Node {
	private List<Node> nodeList;	
	
	public Root(){
		this.nodeList=new ArrayList<Node>();
	}
	@Override
	public Node addSubNode(Node node) {
		nodeList.add(node);
		node.addParentNode(this);
		return this;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		Node node=nodeList.remove(index);
		node.removeParentNode();
		return node;
	}

	@Override
	public void clearSubNodes() {
		for(Node node:this){
			node.removeParentNode();
		}
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
	
	
	public Node getSubNodeByIndex(int index){
		return nodeList.get(index);
	}
}
