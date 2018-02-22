package pers.william.composite.reference_Version_5;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class NodeImpl implements Node {
	
	private List<Node> nodeList;
	private Node parentNode;
	private boolean leaf;
	
	public NodeImpl(){
		this.nodeList=new ArrayList<Node> ();
	}
	public NodeImpl(boolean isLeaf){
		this();
		this.leaf=isLeaf;
	}
	
	public boolean isLeaf() {
		return leaf;
	}

	public void addParentNode(Node parentNode) {
		this.parentNode=parentNode;
	}

	public void removeParentNode() {
		parentNode=null;
	}

	public Node getParentNode() {
		return parentNode;
	}

	public Node addSubNode(Node node) {
		if(leaf){
			return null;
		}
		nodeList.add(node);
		node.addParentNode(this);
		return this;
	}

	public Node removeSubNodeByIndex(int index) {
		if(leaf){return null;}
		Node node=nodeList.remove(index);
		node.removeParentNode();
		return node;
	}

	public void clearSubNode() {
		if(leaf){
			return;
		}
		for(Node node:this){
			node.removeParentNode();
		}
		nodeList.clear();
	}

	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

	public void operation() {
		if(leaf){
			//do leaf's operation
		}else{
			//do Root's operation
		}
	}

}
