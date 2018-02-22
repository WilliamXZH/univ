public class StaticTest
{
	
	private static StaticTest st = new StaticTest("1");
	static{
		System.out.println("abc");
	}

	private static StaticTest st2 = new StaticTest("2");

	public StaticTest(String s){
		System.out.println(s);
	}
	public static StaticTest st4 = new StaticTest("4");

	public static void main(String []args){
		StaticTest st3 = new StaticTest("3");
		
//		int a = 0;
//		int b = 3;
//		int c = a++ + ++b;
//		int d = ++a + b++;
//
//		int i = 1;
		//i++ = ++i;
		//++i = i++;
	}
	static{
		System.out.println("def");
	}
}