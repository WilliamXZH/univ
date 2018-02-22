package pers.william.composite.thirdexper_2;

public class Visitor {
	public void printTree(Node root){
		String depthstr=root.getValue().split("_")[1];
		int depth=Integer.parseInt(depthstr);
		for(int iter=1;iter<depth;iter++)
			System.out.print("\t");
		System.out.println(root.getValue());
		if(root.iterator().hasNext()){
			for(Node subNode:root)
				printTree(subNode);
		}
	}
}
