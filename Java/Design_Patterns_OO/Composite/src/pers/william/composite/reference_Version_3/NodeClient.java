package pers.william.composite.reference_Version_3;

public class NodeClient {
	public Node createTree(){
		Node rootA=new Root();
		Node rootB=new Root();
		Node leafA=new Root();
		Node leafB=new Leaf();
		Node leafC=new Leaf();
		
		rootB.addParentNode(rootA);
		leafA.addParentNode(rootA);
		leafB.addParentNode(rootB);
		leafC.addParentNode(rootB);
		
		rootA.AddSubNode(rootA).AddSubNode(leafA);
		rootB.AddSubNode(leafA).AddSubNode(leafC);
		
		return rootA;
	}
	public void ModifyTree(){
		Node tree=createTree();
		Node leafA=tree.removeSubNodeByIndex(0);
		leafA.removeParentNode();
	}
}
