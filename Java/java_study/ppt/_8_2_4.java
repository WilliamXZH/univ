import java.util.regex.*;
public class _8_2_4
{
	public static void main(String[]args){
		String textString=new String("Java");
		String textString2=textString+"��̴ʵ�";
		StringBuilder builder=new StringBuilder("Java");
		StringBuilder builder2=builder.append("��̴ʵ�");
		System.out.println("ʹ��String�����������:"+textString2);
		System.out.println("ʹ��StringBuilder�������ӣ�"+builder2);
		String regex="0\\d{2,3}[-]?{7,8}|0\\d{2,3}\\s?\\d{7,8}"
			+"|13[0-9]\\d{8}|15[1089]\\d{8}";
		String str="13**4319342";
		Pattern pattern=Pattern.compile(regex);
		Matcher matcher=pattern.matcher(str);
		boolean bool=matcher.matches();
		if(bool==true){
			System.out.println("�Ϸ���������ʽ");
		}else{
			System.out.println("���Ϸ���������ʽ");
		}
	}
}