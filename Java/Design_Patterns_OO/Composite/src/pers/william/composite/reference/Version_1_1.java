package pers.william.composite.reference;

import java.util.ArrayList;
import java.util.List;

interface Node {
	public void operation();
}
class Leaf implements Node{
	public void operation(){
		
	}
}
class Root implements Node{
	private List<Node> nodeList;
	public Root(){
		nodeList=new ArrayList<Node>();		
	}
	public void operation() {
		// TODO Auto-generated method stub
		for(Node node:nodeList){
			node.operation();
		}
	}
	public void addSubNode(Node node){
		nodeList.add(node);
	}
	public Node removeSubNodeByIndex(int index){
		return nodeList.remove(index);
	}
	public void clearSubNodes(){
		nodeList.clear();
	}
	
	public int getSubNodesSize(){
		return nodeList.size();
	}
	public Node getSubNodeByIndex(int index){
		return nodeList.get(index);
	}
}
class NodeClient{
	public Node createTree(){
		Root rootA=new Root();
		Root rootB=new Root();
		
		Leaf leafA=new Leaf();
		Leaf leafB=new Leaf();
		Leaf leafC=new Leaf();
		//Leaf leafD=new Leaf();
		
		rootA.addSubNode(rootB);
		rootA.addSubNode(leafA);
		rootB.addSubNode(leafB);
		rootB.addSubNode(leafC);
		return rootA;
	}
}