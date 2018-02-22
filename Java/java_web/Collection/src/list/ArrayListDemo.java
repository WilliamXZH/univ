package list;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * @ClassName: ArrayListDemo
 * @Description: ArrayList测试类
 * @author William
 * @date: 2017年7月21日 下午9:06:11
 * @date: ${date}
 */
public class ArrayListDemo {

	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList();
		list.add("苏东坡");//0
		list.add("枕边人");//1
		list.add("穿山甲");//2
		list.add("boy");//3
		list.add(1,"一人一世界");//1
		//list.remove("一人一世界");
		//list.removeAll(list);//移除所有元素
		//list.clear();//清除所有元素
		
		/**
		 * 迭代器
		 * 循环遍历集合
		 */
		Iterator iterator = list.iterator();
		
		while(iterator.hasNext()){
			System.out.print(iterator.next()+"\t");
		}
		System.out.println();
		for(int i=0;i<list.size();i++){
			System.out.print(list.get(i)+"\t");
		}
		System.out.println();
		
		for(Object object: list){
			System.out.print(object);
		}
		
		System.out.println();
		System.out.println(list);
		System.out.println(list.isEmpty());
		
	}
	
}
