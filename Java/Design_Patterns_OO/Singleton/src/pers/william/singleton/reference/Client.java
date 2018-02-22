package pers.william.singleton.reference;

public class Client {
	public static void main(String[] args){
		
		
		LazySingleton lazy = LazySingleton.getInstance();
		EagerSingleton eager = EagerSingleton.getInstance();
		//���ʵ������ӡnumber
		lazy.printNumber();
		eager.printNumber();
		System.out.println("\n�ٴδ�ӡ\n");
		LazySingleton lazyAgain = LazySingleton.getInstance();
		EagerSingleton eagerAgain = EagerSingleton.getInstance();
		//�ٴλ��ʵ������ӡnumber���鿴number�Ƿ�����
		lazyAgain.printNumber();
		eagerAgain.printNumber();
	}
}
