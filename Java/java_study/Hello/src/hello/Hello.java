package hello;

import java.util.*;

public class Hello {
	/**
	 * @author William
	 * @version 1.0.0
	 * @date 2017��9��18�� ����12:15:50
	 * @method main
	 * @see (һ�仰�����������������)
	 * (����ʹ������---��ѡ)
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
