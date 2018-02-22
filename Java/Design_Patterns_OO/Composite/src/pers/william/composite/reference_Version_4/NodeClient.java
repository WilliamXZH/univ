package pers.william.composite.reference_Version_4;

public class NodeClient {
	public Node createTree(){
		Node rootA=new Root();
		Node rootB=new Root();
		Node leafA=new Leaf();
		Node leafB=new Leaf();
		Node leafC=new Leaf();
		
		rootA.addSubNode(rootB).addSubNode(leafA);
		rootB.addSubNode(leafB).addSubNode(leafC);
		
		return rootA;
	}
	public void ModifyTree(){
		Node tree=createTree();
		tree.removeSubNodeByIndex(0);
	}
}
