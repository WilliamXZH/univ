package pers.william.composite.thirdexper_2;

public class ConcreteBuilder {
	public void createTreeByRecursion(Node node,int currentDepth,int totalDepth,String postfix){
		node.setValue(node.getValue()+"_"+currentDepth+postfix);
		if(totalDepth<=1||currentDepth>totalDepth)return;
		else if(currentDepth==totalDepth-1){
			Node leafA=new Leaf();
			createTreeByRecursion(leafA, currentDepth+1, totalDepth, postfix+"_1");
			
			Node leafB=new Leaf();
			createTreeByRecursion(leafB,currentDepth+1,totalDepth,postfix+"_2");
			
			node.addSubNode(leafA).addSubNode(leafB);
		}else if(currentDepth<totalDepth-1){

			Node rootA=new Root();
			createTreeByRecursion(rootA, currentDepth+1, totalDepth, postfix+"_1");
			
			Node rootB=new Root();
			createTreeByRecursion(rootB,currentDepth+1,totalDepth,postfix+"_2");
			
			node.addSubNode(rootA).addSubNode(rootB);
		}
	}
	public Node createTreeByIteration(int totalDepth){
		boolean isRoot=true;
		Root root=new Root();
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
		//System.out.println("???");		
		while(currentDepth<depth){
			middle=(left+right)/2;
			currentDepth++;
			if(num<middle){
				//System.out.println(currentDepth+"?"+depth);
				if(currentDepth<depth)root=root.getSubNodeByIndex(0);
				postfix+="_1";
				right=middle;
			}else{
				if(currentDepth<depth)root=root.getSubNodeByIndex(1);
				postfix+="_2";
				left=middle;
			}
		}
		//System.out.println(depth);

		if(isRoot){
			subnode=new Root();
		}else{
			subnode=new Leaf();
		}
		subnode.setValue(subnode.getValue()+"_"+depth+postfix);
		root.addSubNode(subnode);
	}
}
