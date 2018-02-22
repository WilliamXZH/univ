package pers.william.composite.thirdexper_2;

import java.util.Scanner;


public class Test {
	public static void main(String []args){
		Builder builder;
		Node root;
		Director dir;
		
		Visitor visitor=new Visitor();
		
		int depth = 0;
		boolean flags;
		Scanner scan=new Scanner(System.in);;
		do{
			do{
				flags=false;
				System.out.println("0 represents the terminal of the execution.");
				System.out.print("Please input a depth of tree:");
				String str= scan.next();
				try{
					depth=Integer.parseInt(str);
				}catch(NumberFormatException e){
					flags=true;
					System.out.println("«Î ‰»Î ˝◊÷:"+e.toString());
				}
			}while(flags);		
			if(depth==0){
				break;
			}
			else if(depth<0){					
				builder=new BuilderConcreteByRecusion();
				depth=-depth;
			}else{						
				builder=new BuilderConcreteByIteration();
			}		
			
			dir=new Director(builder);
			root=dir.construct(depth);
			visitor.printTree(root);			
			

			//System.out.println("finished!");
		}while(depth>0);
		scan.close();
		System.out.println("Terminated!");
	}
}
