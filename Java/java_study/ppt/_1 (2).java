
class _1
{
	String str=null;
	public static void main(String[] args){
		byte[] byteArray=new byte[]{65,66,67};
		String str =new String(byteArray);
		System.out.println(str);
		char []charArray=new char[]{'c','d','d'};
		String str3;
		str3=new String(charArray);
		System.out.println(str3);
		//str3=new String(StringBuffer buffer);
		//str3=new String(StringBuilder builder);
		int appleNum=6;
		float price=1.50f;
		str="����"+appleNum+"��ƻ����ÿ��ƻ������"+price+"ԪǮ��";
		System.out.println(str);
//		String str2=new String(byteArray,"GB2312");
		int x = 5;     int y = 2;     System.out.println(x + "1" + y);
	}
}