package pers.william.singleton.reference;

public class Client {
	public static void main(String[] args){
		
		
		LazySingleton lazy = LazySingleton.getInstance();
		EagerSingleton eager = EagerSingleton.getInstance();
		//获得实例，打印number
		lazy.printNumber();
		eager.printNumber();
		System.out.println("\n再次打印\n");
		LazySingleton lazyAgain = LazySingleton.getInstance();
		EagerSingleton eagerAgain = EagerSingleton.getInstance();
		//再次获得实例，打印number，查看number是否增加
		lazyAgain.printNumber();
		eagerAgain.printNumber();
	}
}
