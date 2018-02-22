package pers.william.composite.thirdexper;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Root extends Node{
	
	private List<Node> nodeList;
	
	
	public Root(){
		this.nodeList=new ArrayList<Node>();
	}
	public Root(int totalDepth){
		this(1,totalDepth,"");
	}
	public Root(int currentDepth,int totalDepth,String postfix){
		this();
		this.setValue(this.getValue()+"_"+currentDepth+postfix);
		if(currentDepth<totalDepth-1){
			Node rootA=new Root(currentDepth+1,totalDepth,postfix+"_"+1);
			Node rootB=new Root(currentDepth+1,totalDepth,postfix+"_"+2);
			
			this.addSubNode(rootA).addSubNode(rootB);
		}else{
			Node leafA=new Leaf(currentDepth+1,totalDepth,postfix+"_"+1);
			Node leafB=new Leaf(currentDepth+1,totalDepth,postfix+"_"+2);
			
			addSubNode(leafA).addSubNode(leafB);
		}
	}
	
	@Override
	public void clearSubNode() {
		for(Node node:nodeList){
			node.removeParentNode();
		}
		nodeList.clear();
	}

	@Override
	public void operation(int currentDepth) {	
		super.operation(currentDepth);
		for(Node node:this)
			node.operation(currentDepth+1);
	}

	@Override
	public Node addSubNode(Node node) {
		nodeList.add(node);
		node.addParentNode(this);
		return this;
	}

	@Override
	public Node removeSubNodeByIndex(int index) {
		Node node=nodeList.get(index);
		node.removeParentNode();
		return node;
	}

	@Override
	public Iterator<Node> iterator() {
		return nodeList.iterator();
	}

}
