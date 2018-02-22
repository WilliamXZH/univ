package hello;

import java.util.*;

public class Hello {
	/**
	 * @author William
	 * @version 1.0.0
	 * @date 2017年9月18日 上午12:15:50
	 * @method main
	 * @see (一句话描述这个方法的作用)
	 * (方法使用条件---可选)
	 * @param args
	 * @return void
	 * @throws 
	 */
	public static void main(String args[]){
		StringTokenizer st = new StringTokenizer("this is,a,test of tokens", ",");
		String s;  int count = 0;
		while (st.hasMoreTokens())  {        
			s = st.nextToken();
		++count;
		}  
		System.out.println(count);
		int x = 5;     
		int y = 2;     
		System.out.println(x + y);
	}

}
