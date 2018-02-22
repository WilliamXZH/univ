package pers.william.composite.reference;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import pers.william.composite.reference_Version_1_1.Leaf;
import pers.william.composite.reference_Version_1_1.Node;
import pers.william.composite.reference_Version_1_2.Root;

class Root_2 implements Node,Iterable<Node>{

	private List<Node> nodeList;
	public Root_2(){
		nodeList=new ArrayList<Node>();
	}	
	
	public Iterator<Node> iterator() {
		// TODO Auto-generated method stub
		return nodeList.iterator();
	}

	public void operation() {
		// TODO Auto-generated method stub
		
		//pre-operations here
		for(Node node:this){
			node.operation();
		}
		//post-operation here
	}
	public Root_2 addSubNode(Node node){
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
class NodeClient_2 {
	public Node createTree(){
			
		Root rootA=new Root();
		Root rootB=new Root();
		Leaf leafA=new Leaf();
		Leaf leafB=new Leaf();
		Leaf leafC=new Leaf();
		
		rootA.addSubNode(rootB)
			.addSubNode(leafA);
		rootB.addSubNode(leafB)
			.addSubNode(leafC);
		
		return rootA;
	}
}
