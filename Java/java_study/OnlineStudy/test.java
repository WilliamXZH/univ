import java.util.Collection;
import java.util.ArrayList;
import java.util.Iterator;
public class test
{
	public static void main(String[] args){
		Collection<String> a=new ArrayList<String>();
		a.add("100");
		a.add("100");
		a.add("#100");
		a.add("100");
		int sum=0;
		System.out.println(a);
		Iterator b=a.iterator();
		while(b.hasNext()){
			Object c=(String)b.next();
			if(c.equal("100")){
				sum+=Integer.parseInt((String )c);

			}else {
				System.out.println("发现。。。。");
			}
		}

	System.out.println("共"+sum+"元");
	}
}