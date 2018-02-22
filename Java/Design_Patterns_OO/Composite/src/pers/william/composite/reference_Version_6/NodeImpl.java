package pers.william.composite.reference_Version_6;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class NodeImpl implements Node {

	private List<Node> nodeList;
	private Node parentNode;
	private boolean root;
	
	public NodeImpl(){
		this.nodeList=new ArrayList<Node>();
	}
	
	public boolean isRoot() {
		return root;
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
		root=true;
		nodeList.add(node);
		node.addParentNode(this);
		return this;
	}

	public Node removeSubNodeByIndex(int index) {
		Node node=null;
		if(root){
			node=nodeList.remove(index);
			node.removeParentNode();
		}
		root=!nodeList.isEmpty();
		return node;
	}

	public void clearSubNodes() {
		if(root){
			for(Node node:this){
				node.removeParentNode();
			}
		}
		nodeList.clear();
		root=false;
	}

	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

	public void operation() {
		if(root){
			//do Root's operation
		}else{
			//do Leaf's operation
		}
	}

}
