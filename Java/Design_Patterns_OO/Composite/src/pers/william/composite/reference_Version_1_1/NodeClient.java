package pers.william.composite.reference_Version_1_1;

public class NodeClient {
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
