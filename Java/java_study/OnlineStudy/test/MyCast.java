class Base
{
}

public class MyCast extends Base
{
	static boolean b1=false;
	static int i=-1;
	static double d=10.1;
	public static void main(String args[]){
		MyCast m=new MyCast();
		Base b=new Base();

		b=m;//A
		//m=b;//B
		//d=i;//C
		//b1=i;//D

		//String a[]=new String[5];
		//String []a=new String[];a={" "," "," "," "," "};
		//String []a={" "," "," "," "," "};
		//String []a=new String[]{" "," "," "," "," "};
		//
	}
}