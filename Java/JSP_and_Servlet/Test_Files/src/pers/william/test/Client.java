package pers.william.test;

public class Client {
	public static String getClientSQL(int n){
		//int n=ids.length;
		
		String tmp="prompt Loading CLIENT...\r\n";
		String first="��Ǯ��������֣���������������"
				+ "�����������ʩ�ſײ��ϻ���κ�ս�"
				+ "��л������ˮ��������˸��ɷ�����"
				+ "³Τ������ﻨ������Ԭ��ۺ��ʷ��"
				+ "�����Ѧ�׺����������ޱϺ�������"
				+ "����ʱ��Ƥ���뿵����Ԫ������ƽ��"
				+ "��������Ҧ��տ����ë����ױ����"
				+ "�Ʒ��ɴ�̸��é���ܼ�������ף����"
				+ "��������ϯ����ǿ��·¦Σ��ͯ�չ�"
				+ "÷ʢ�ֵ�����������Ĳ��﷮�����"
				+ "����֧���ù�¬Ī�������Ѹɽ�Ӧ��"
				+ "�����ڵ��������������ʯ�޼�ť��"
				+ "�����ϻ���½��������춻����L�ҷ�"
				+ "���ഢ���������ɾ��θ����ڽ��͹�"
				+ "����ɽ�ȳ������ȫۭ������������"
				+ "�����ﱩ��б�������������ղ����"
				+ "Ҷ��˾��۬�輻��ӡ�ް׻���ۢ�Ӷ�"
				+ "���̼���׿�����ɳ����������ܲ�˫"
				+ "��ݷ����̷�����̼������Ƚ��۪Ӻ"
				+ "�S�ɣ���ţ��ͨ�����༽ۣ����ũ"
				+ "�±�ׯ�̲����ֳ�Ľ����ϰ�°�����"
				+ "����������������߾Ӻⲽ��������"
				+ "����Ŀܹ�»�ڶ�ŷ�����εԽ��¡"
				+ "ʦ�������˹��������������Ǽ��Ŀ�"
				+ "����ɳؿ������ᳲ�������󾣺�"
				+ "����Ȩ�ϸ��滸��";
		String road[]={"�����","������","������","Ȫ԰��","���ֽ�"
				,"����Ž�","�����","Ӣ���","ǰ����","������"
				,"������","���ɽ�","ף�ҽ�","�߿���","�����"};
		int size=first.length();
		
		for(int i=0;i<n;i++){
			//ids[i]=Utils.getRandomInt()%1000+300;
//			boolean flag=true;
//			while(flag){
//				flag=false;
//				//ids[i]=Utils.getRandomInt()%1000+300;
//				for(int j=0;j<i;j++){
//					if(ids[i]==ids[j]){
//						flag=true;
//						break;
//					}
//				}
//			}
			
			tmp+="insert into CLIENT (id, name, address, tel) values ("
					//+ids[i]+",\'"+first.charAt(Utils.getRandomInt()%size)
					+(i+1)+",\'"+first.charAt(Utils.getRandomInt()%size)
					//+ids[i]+"\',\'��������"+road[Utils.getRandomInt()%road.length]+ids[i]
					+i+"\',\'��������"+road[Utils.getRandomInt()%road.length]+i
					+"��\',\'"+(Utils.getRandomInt()%100000+100000)+""
					+(Utils.getRandomInt()%90000+10000)+"\');\r\n";
			if(i%100==99)tmp+="commit;\r\n"
					+"prompt "+(i+1)+" records committed...\r\n";
		}
		
		
		return tmp;
	}
}
