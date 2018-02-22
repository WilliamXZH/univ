public class SwapTest
{

	public void swap(String a,String b){
		String t = a;
		a = b;
		b = t;
	}

	public static void main(String args[]){
		SwapTest st = new SwapTest();
		String s = "abcdefg";
		String t = "1234567";
		st.swap(s,t);
		System.out.println(s+":"+t);
	}
}