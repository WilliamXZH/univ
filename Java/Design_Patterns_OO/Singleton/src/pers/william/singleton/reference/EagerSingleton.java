package pers.william.singleton.reference;




public final class EagerSingleton {
	//饿汉单例模式
	//类加载时就完成初始化

	private static EagerSingleton instance = new EagerSingleton();   //静态私有成员，已初始化
	private static int number;
	
	
	

	private EagerSingleton(){  //构造函数
		number++;
	}

	public static EagerSingleton getInstance(){
		return instance;
	}
	

	public void printNumber(){
		System.out.println("这是EagerSingleton.");
		System.out.println("The number is "+number);
	}
}

