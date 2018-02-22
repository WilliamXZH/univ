package pers.william.composite.thirdexper_2;

public class BuilderConcreteByRecusion implements Builder {

	public Node build(int totalDepth){
		
		return Recursion(new Root(),1,totalDepth,"");
	}
	private Node Recursion(Node node,int currentDepth,int totalDepth,String postfix){
		
		node.setValue(node.getValue()+"_"+currentDepth+postfix);
		if(totalDepth<=1||currentDepth>=totalDepth)return node;
		else if(currentDepth==totalDepth-1){
			Node leafA=new Leaf();
			Recursion(leafA, currentDepth+1, totalDepth, postfix+"_1");
			
			Node leafB=new Leaf();
			Recursion(leafB,currentDepth+1,totalDepth,postfix+"_2");
			
			node.addSubNode(leafA).addSubNode(leafB);
		}else if(currentDepth<totalDepth-1){

			Node rootA=new Root();
			Recursion(rootA, currentDepth+1, totalDepth, postfix+"_1");
			
			Node rootB=new Root();
			Recursion(rootB,currentDepth+1,totalDepth,postfix+"_2");
			
			node.addSubNode(rootA).addSubNode(rootB);
		}
		return node;
	}
	
}
