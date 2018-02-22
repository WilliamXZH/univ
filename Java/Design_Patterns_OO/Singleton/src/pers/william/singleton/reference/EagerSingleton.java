package pers.william.singleton.reference;




public final class EagerSingleton {
	//��������ģʽ
	//�����ʱ����ɳ�ʼ��

	private static EagerSingleton instance = new EagerSingleton();   //��̬˽�г�Ա���ѳ�ʼ��
	private static int number;
	
	
	

	private EagerSingleton(){  //���캯��
		number++;
	}

	public static EagerSingleton getInstance(){
		return instance;
	}
	

	public void printNumber(){
		System.out.println("����EagerSingleton.");
		System.out.println("The number is "+number);
	}
}

