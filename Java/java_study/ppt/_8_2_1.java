public class _8_2_1
{
	public static void main(String []args){
		String str="mingrikeji";
		int rs=str.indexOf('i');
		System.out.println("�ַ�i�״γ��ֵ�λ����:"+rs);
		rs=str.lastIndexOf('i');
		System.out.println("�ַ�i���һ�γ��ֵ�λ����:"+rs);
		rs=str.lastIndexOf("ri");
		System.out.println("�ַ���ri�״γ��ֵ�λ����:"+rs);
		rs=str.lastIndexOf('1','4');
		System.out.println("�ӵ�5���ַ����ַ�i�״γ��ֵ�λ����:"+rs);
		String substr=str.substring(0,6);
		System.out.println(substr);
		String str2="  ��˾��ַ�����տƼ�  ";
		str2=str2.replace("��ַ","����");
		str2=str2.trim();
		System.out.println(str2);
		String str3="��˾����:���տƼ�����˾���ڳ��У������С���˾�绰��84972266";
		String[] info=null;
		info=str3.split("��|��");
		for(int i=0;i<info.length;i++){
			System.out.println(info[i]);
		}
	}
}