import java.util.*;
public class _8_2_2
{
	public static void main(String []args){
		String str=null;
		str=String.format("Hi,%s","����");
		System.out.println(str);
		System.out.print(String.format("��ĸa�Ĵ�д��:%c %n",'A'));
		System.out.print(String.format("3>7�Ľ���ǣ�%b %n",3>7));
		System.out.print(String.format("100��һ���ǣ�%d %n",100/2));
		System.out.print(String.format("100��16������:%x %n",100));
		System.out.print(String.format("100��8�����ǣ�%o %n",100));
		System.out.print(String.format("50Ԫ�����8.5�ۿ��ǣ�%fԪ %n",50*0.85));
		System.out.print(String.format("����۸��16������ʮ��%a%n",50*0.85));
		System.out.print(String.format("����۸��ָ����ʾ��%e%n",50*0.85));
		System.out.print(String.format("����۸��ָ���͸���������ĳ��Ƚ϶̵��ǣ�%g%n",50*0.85));
		System.out.print(String.format("������ۿ���%d%% %n",85));
		System.out.print(String.format("��ĸA��ɢ�����ǣ�%h%n",'A'));
		System.out.print(String.format("��ʽ������S��ʹ��:%1$d,%2$s",99,"abc"));
		System.out.print(String.format("��ʾ�������ķ���:%+d��%d%n",99,-99));
		System.out.print(String.format("��ţ�ı����:%03d%n",7));
		System.out.print(String.format("Tab����Ч����:% 8d%n",7));
		System.out.print(String.format("���������Ч����:%,d%n",9989997));
		System.out.print(String.format("һ����ļ۸���:%2.2fԪ%n",49.8));
		Date date=new Date();
		System.out.print(String.format("ȫ�����ں�ʱ����Ϣ:%tc%n",date));
		System.out.print(String.format("��-��-�ո�ʽ:%tF%n",date));
		System.out.print(String.format("��/��/���ʽ:%tD%n",date));
		System.out.print(String.format("HH:MM:SS PM��ʽ(12ʱ��):%tr%n",date));
		System.out.print(String.format("HH:MM:SS��ʽ()24ʱ��:%tT%n",date));
		System.out.print(String.format("HH:MM:SS��ʽ(24ʱ��):%tR",date));
	}
}