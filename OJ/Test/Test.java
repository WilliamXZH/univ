

public class Test
{
	public static boolean test(int i){
		System.out.println(i);
		return false;
	}
	public static void main(String[] args){
//		String s="12345#aaa#bbb#67890";
//		int n=s.indexOf("#");
//		System.out.println(s.length());
//		int k=s.indexOf("#",n+1);
//		System.out.println(k);
//		int m=s.indexOf("#",k+1);
//		System.out.println(m);
//		String s2=s.substring(m+1);
//		System.out.println(s2);
//		Integer a = 1;
//		Integer b = 1;
//		int c = 1;
//		int d = 1;
//		System.out.println(c==d);
//		double x = (double)3/2+1;
//		System.out.println(x);
//		System.out.println(2<<3);
		boolean b = 0<10|test(4);
		System.out.println(b);
		b = 0<10||test(8);
	}
}