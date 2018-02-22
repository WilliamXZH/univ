package pers.william.composite.thirdexper;

import java.util.Scanner;

public class NodeClient {
	public Node createTree(){
		
		int depth = 0;
		boolean flags;
		Node root;
		Scanner scan=new Scanner(System.in);
		do{
			do{
				flags=false;
				System.out.print("Please input a depth of tree:");
				String str= scan.next();
				try{
					depth=Integer.parseInt(str);
				}catch(NumberFormatException e){
					flags=true;
					System.out.println("«Î ‰»Î ˝◊÷:"+e.toString());
				}
			}while(flags);		
			root=new Root(depth);
			root.operation(0);
			scan.close();
		}while(depth<0);
			

		return root;
	}
	public static void main(String []args){
		NodeClient client=new NodeClient();
		client.createTree();
	}
}
