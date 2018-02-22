package pers.william.decorator.secondexper;

public class ReceiptDecorator extends Decorator {

	ReceiptDecorator(Component component) {
		super(component);
	}

	@Override
	public void draw() {
		
		component.draw();
		System.out.println("��ӡ��=40");
		System.out.println("\t14�칺�ﱣ�ϣ�ƾ���ݿ�����/�����ϣ�");
		System.out.println("\tӡ����һ���˻أ���������ĵ��ں�����");
		System.out.println("\t        ���Ļ�����    �绰:23687759");
		System.out.println("18-03-2010 15:59:33 R#01 C:3895 MAY\tT#26142296");
		System.out.println("������������������������������������������������������������������������������������������������");
		System.out.println("\t��ȡ���Ϲ������ɸ�ÿ���۱���Ż����ɷѣ�");
		System.out.println("\t\t�ɷѲ����˿�");
	}

}
