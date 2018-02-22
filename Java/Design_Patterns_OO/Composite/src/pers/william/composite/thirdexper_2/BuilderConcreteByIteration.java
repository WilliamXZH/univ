package pers.william.composite.thirdexper_2;

public class BuilderConcreteByIteration implements Builder {

	public Node build(int totalDepth) {
		
		return Iteration(new Root(),totalDepth);
	}
	private Node Iteration(Root root,int totalDepth){
		boolean isRoot=true;
		root.setValue(root.getValue()+"_1");
		if(totalDepth<=1)return root;
		
		for(int iter_depth=2;iter_depth<=totalDepth;iter_depth++){
			int width=(int)Math.pow(2, iter_depth-1);
			if(iter_depth==totalDepth)isRoot=false;
			for(int iter_width=0;iter_width<width;iter_width++){
				addNode(root,iter_width,width,iter_depth,isRoot);
			}
		}
		return root;
	}
	private void addNode(Node root,int num,int width,int depth,boolean isRoot){
		String postfix="";
		int left=0,right=width,middle;
		int currentDepth=1;
		
		Node subnode;	
		while(currentDepth<depth){
			middle=(left+right)/2;
			currentDepth++;
			if(num<middle){
				if(currentDepth<depth)root=root.getSubNodeByIndex(0);
				postfix+="_1";
				right=middle;
			}else{
				if(currentDepth<depth)root=root.getSubNodeByIndex(1);
				postfix+="_2";
				left=middle;
			}
		}

		if(isRoot){
			subnode=new Root();
		}else{
			subnode=new Leaf();
		}
		subnode.setValue(subnode.getValue()+"_"+depth+postfix);
		root.addSubNode(subnode);
	}
}
