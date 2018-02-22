package pers.william.composite.reference_Version_6;

public class NodeClient {
	public Node createTree(){
		Node rootA=new NodeImpl();
		Node rootB=new NodeImpl();
		Node leafA=new NodeImpl();
		Node leafB=new NodeImpl();
		Node leafC=new NodeImpl();
		
		rootA.addSubNode(rootB).addSubNode(leafA);
		rootB.addSubNode(leafB).addSubNode(leafC);
		
		return rootA;
	}
	public void ModifyTree(){
		Node tree=createTree();
		tree.removeSubNodeByIndex(0);
	}
}
