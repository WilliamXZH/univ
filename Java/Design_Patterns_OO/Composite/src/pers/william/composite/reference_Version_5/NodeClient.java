package pers.william.composite.reference_Version_5;

public class NodeClient {
	public Node createTree(){
		Node rootA=new NodeImpl(false);
		Node rootB=new NodeImpl(false);
		Node leafA=new NodeImpl(true);
		Node leafB=new NodeImpl(true);
		Node leafC=new NodeImpl(true);
		
		rootA.addSubNode(rootB).addSubNode(leafA);
		rootB.addSubNode(leafB).addSubNode(leafC);
		
		return rootA;
	}
	public void ModifyTree(){
		Node tree=createTree();
		tree.removeSubNodeByIndex(0);
	}
}
