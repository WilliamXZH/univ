package pers.william.composite.reference_Version_1_2;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import pers.william.composite.reference_Version_1_1.Node;

public class Root implements Node,Iterable<Node>{
	private List<Node> nodeList;
	public Root(){
		nodeList=new ArrayList<Node>();
	}	
	
	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

	public void operation() {
		//pre-operations here
		for(Node node:this){
			node.operation();
		}
		//post-operation here
	}
	public Root addSubNode(Node node){
		nodeList.add(node);
		return this;
	}
	public Node removeSubNodeByIndex(int index){
		return nodeList.remove(index);
	}
	public void clearSubNodes(){
		nodeList.clear();
	}
}
