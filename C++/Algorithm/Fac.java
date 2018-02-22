import java.util.Scanner;

public class Fac
{
	static void dfs(int a,int b,int c,int n){
		if(c>=n){
			return;
		}else{
			System.out.println(a+b);
			dfs(b,a+b,c+1,n);
		}
	}

	public static void main(String []args){
		Scanner scan = new Scanner(System.in);
		int n = scan.nextInt();
		System.out.println(1);
		dfs(0,1,1,n);
//		int a[] = new int[20];
//		a[0] = 1;
//		a[1] = 1;
//		System.out.println(a[0]+"\n"+a[1]);
//		for(int i=2;i<20;i++){
//			a[i] = a[i-1]+a[i-2];
//			System.out.println(a[i]);
//		}
	}
}