import java.util.*;
public class _8_2_3
{
	public static void main(String []args){
		Date date=new Date();
		String str=String.format(Locale.US,"英文月份简称:%tb",date);
		System.out.println(str);
		System.out.println(String.format(Locale.US,"英文月份全称:%tB",date));
		System.out.println(str);
		System.out.println(String.format("本地月份全称:%tB",date));
		str=String.format(Locale.US,"英文月份全称：%tB",date);
		System.out.println(str);
		System.out.println(String.format("本地月份全称:%tB%n",date));
		str=String.format(Locale.US,"英文星期的简称:%ta",date);
		System.out.println(str);
		System.out.println(String.format("本地星期的简称：%tA%n",date));
		System.out.println(String.format("年的前两位数字（不足两位前面补0）：%tC%n",date));
		System.out.println(String.format("年的后两位数字（不足两位前面补0）：%ty%n",date));
		System.out.println(String.format("一年中的天数（即年的第几天）：%tj%n",date));
		System.out.println(String.format("两位数字的月份（不足两位前面补0）：%tm%n",date));
		System.out.println(String.format("两位数字的日（不足两位前面补0）:%td%n",date));
		System.out.println(String.format("月份的日（前面不补0）:%te",date));
		System.out.println(String.format("两位数字24时制的小时（不足两位前面补0）:%tH%n",date));
		System.out.println(String.format("两位数字12时制的小时（不足两位前面补0）：%tI%n",date));
		System.out.println(String.format("两位数字24时制的小时（前面不补0）:%tk%n",date));
		System.out.println(String.format("两位数字12时制的小时（前面不补0）:%tl%n",date));
		System.out.println(String.format("两位数字的分钟(不足两位前面补0):%tM%n",date));
		System.out.println(String.format("两位数字的秒（不足两位前面补0）:%tS%n",date));
		System.out.println(String.format("两位数字的毫秒（不足3位前面补0）:%tL%n",date));
		System.out.println(String.format("两位数字的毫秒数(不足9位前面补0)：%tN%n",date));
		String str2=String.format(Locale.US,"小写字母的上午或下午标记（英）:%tp%n",date);
		System.out.println(str2);
		System.out.println(String.format("小写字母的上午或下午标记（中）:%tp%n",date));
		System.out.println(String.format("相对于GMT的RFC822时区的偏移量:%tz%n",date));
		System.out.println(String.format("时区缩写字符串:%tz%n",date));
		System.out.println(String.format("1970-1-1 00:00:00到现在所经过的秒数:%ts%n",date));
		System.out.println(String.format("1970-1-1 00:00:00到现在所经过的毫秒数:%tO%n",date));
		}
}