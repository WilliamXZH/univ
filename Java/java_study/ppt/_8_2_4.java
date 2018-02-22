import java.util.regex.*;
public class _8_2_4
{
	public static void main(String[]args){
		String textString=new String("Java");
		String textString2=textString+"编程词典";
		StringBuilder builder=new StringBuilder("Java");
		StringBuilder builder2=builder.append("编程词典");
		System.out.println("使用String对象进行连接:"+textString2);
		System.out.println("使用StringBuilder进行连接："+builder2);
		String regex="0\\d{2,3}[-]?{7,8}|0\\d{2,3}\\s?\\d{7,8}"
			+"|13[0-9]\\d{8}|15[1089]\\d{8}";
		String str="13**4319342";
		Pattern pattern=Pattern.compile(regex);
		Matcher matcher=pattern.matcher(str);
		boolean bool=matcher.matches();
		if(bool==true){
			System.out.println("合法的正则表达式");
		}else{
			System.out.println("不合法的正则表达式");
		}
	}
}