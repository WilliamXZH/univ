package pers.william.composite.reference_Version_1_2;

import pers.william.composite.reference_Version_1_1.Leaf;
import pers.william.composite.reference_Version_1_1.Node;

public class NodeClient {
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
