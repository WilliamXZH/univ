package pers.william.singleton.reference;


public final class LazySingleton {
	//懒汉单例模式
	
	private static LazySingleton instance;  //静态私有成员，未初始化
	private static int number;
	
	private LazySingleton(){  //构造函数
		number++;
	}
	
	public static LazySingleton getInstance(){
		if(instance == null){
			instance = new LazySingleton();
		}
		return instance;
	}
	
	public void printNumber(){
		System.out.println("这是LazySingleton.");
		System.out.println("The number is "+number);
	}
}
