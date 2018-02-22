package pers.william.composite.reference_Version_1_1;

import java.util.ArrayList;
import java.util.List;

public class Root implements Node {
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
