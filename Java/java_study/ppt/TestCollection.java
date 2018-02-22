import java.util.Collection;
import java.util.ArrayList;
//import java.lang.Iterable;
import java.util.Iterator;
public class TestCollection
{
	public static void main(String []args){
		String apple="apple";
		String banana="banana";
		String pear="pear";
		Collection<String> list=new ArrayList<String>();
		list.add(apple);
		list.add(banana);
		Collection<String> list2=new ArrayList<String>();

		list2.addAll(list);
		list2.add(pear);
		Iterator<String> it=list2.iterator();
		while(it.hasNext()){
			String str=it.next().toString();
			System.out.println(str);
		}
	}
}