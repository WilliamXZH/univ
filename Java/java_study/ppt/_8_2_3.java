import java.util.*;
public class _8_2_3
{
	public static void main(String []args){
		Date date=new Date();
		String str=String.format(Locale.US,"Ӣ���·ݼ��:%tb",date);
		System.out.println(str);
		System.out.println(String.format(Locale.US,"Ӣ���·�ȫ��:%tB",date));
		System.out.println(str);
		System.out.println(String.format("�����·�ȫ��:%tB",date));
		str=String.format(Locale.US,"Ӣ���·�ȫ�ƣ�%tB",date);
		System.out.println(str);
		System.out.println(String.format("�����·�ȫ��:%tB%n",date));
		str=String.format(Locale.US,"Ӣ�����ڵļ��:%ta",date);
		System.out.println(str);
		System.out.println(String.format("�������ڵļ�ƣ�%tA%n",date));
		System.out.println(String.format("���ǰ��λ���֣�������λǰ�油0����%tC%n",date));
		System.out.println(String.format("��ĺ���λ���֣�������λǰ�油0����%ty%n",date));
		System.out.println(String.format("һ���е�����������ĵڼ��죩��%tj%n",date));
		System.out.println(String.format("��λ���ֵ��·ݣ�������λǰ�油0����%tm%n",date));
		System.out.println(String.format("��λ���ֵ��գ�������λǰ�油0��:%td%n",date));
		System.out.println(String.format("�·ݵ��գ�ǰ�治��0��:%te",date));
		System.out.println(String.format("��λ����24ʱ�Ƶ�Сʱ��������λǰ�油0��:%tH%n",date));
		System.out.println(String.format("��λ����12ʱ�Ƶ�Сʱ��������λǰ�油0����%tI%n",date));
		System.out.println(String.format("��λ����24ʱ�Ƶ�Сʱ��ǰ�治��0��:%tk%n",date));
		System.out.println(String.format("��λ����12ʱ�Ƶ�Сʱ��ǰ�治��0��:%tl%n",date));
		System.out.println(String.format("��λ���ֵķ���(������λǰ�油0):%tM%n",date));
		System.out.println(String.format("��λ���ֵ��루������λǰ�油0��:%tS%n",date));
		System.out.println(String.format("��λ���ֵĺ��루����3λǰ�油0��:%tL%n",date));
		System.out.println(String.format("��λ���ֵĺ�����(����9λǰ�油0)��%tN%n",date));
		String str2=String.format(Locale.US,"Сд��ĸ������������ǣ�Ӣ��:%tp%n",date);
		System.out.println(str2);
		System.out.println(String.format("Сд��ĸ������������ǣ��У�:%tp%n",date));
		System.out.println(String.format("�����GMT��RFC822ʱ����ƫ����:%tz%n",date));
		System.out.println(String.format("ʱ����д�ַ���:%tz%n",date));
		System.out.println(String.format("1970-1-1 00:00:00������������������:%ts%n",date));
		System.out.println(String.format("1970-1-1 00:00:00�������������ĺ�����:%tO%n",date));
		}
}