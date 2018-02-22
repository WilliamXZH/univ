package list;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * @ClassName: ArrayListDemo
 * @Description: ArrayList������
 * @author William
 * @date: 2017��7��21�� ����9:06:11
 * @date: ${date}
 */
public class ArrayListDemo {

	public static void main(String[] args) {
		ArrayList<String> list = new ArrayList();
		list.add("�ն���");//0
		list.add("�����");//1
		list.add("��ɽ��");//2
		list.add("boy");//3
		list.add(1,"һ��һ����");//1
		//list.remove("һ��һ����");
		//list.removeAll(list);//�Ƴ�����Ԫ��
		//list.clear();//�������Ԫ��
		
		/**
		 * ������
		 * ѭ����������
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
