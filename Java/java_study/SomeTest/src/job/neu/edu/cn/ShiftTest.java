package job.neu.edu.cn;

public class ShiftTest {

	public static void main(String[] args) {
		int x = -2;
		System.out.printf("%10x\t%d\n",x,x);
		System.out.printf("%10x\t%d\n",x>>1,(x>>1));
		System.out.printf("%10x\t%d\n",x>>>1,(x>>>1));
	}
	
}
