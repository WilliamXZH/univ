package pers.william.singleton.reference;


public final class LazySingleton {
	//��������ģʽ
	
	private static LazySingleton instance;  //��̬˽�г�Ա��δ��ʼ��
	private static int number;
	
	private LazySingleton(){  //���캯��
		number++;
	}
	
	public static LazySingleton getInstance(){
		if(instance == null){
			instance = new LazySingleton();
		}
		return instance;
	}
	
	public void printNumber(){
		System.out.println("����LazySingleton.");
		System.out.println("The number is "+number);
	}
}
