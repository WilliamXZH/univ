import java.util.*;
public class _8_2_2
{
	public static void main(String []args){
		String str=null;
		str=String.format("Hi,%s","飞龙");
		System.out.println(str);
		System.out.print(String.format("字母a的大写是:%c %n",'A'));
		System.out.print(String.format("3>7的结果是：%b %n",3>7));
		System.out.print(String.format("100的一半是：%d %n",100/2));
		System.out.print(String.format("100的16进制是:%x %n",100));
		System.out.print(String.format("100的8进制是：%o %n",100));
		System.out.print(String.format("50元的书打8.5折扣是：%f元 %n",50*0.85));
		System.out.print(String.format("上面价格的16进制数十：%a%n",50*0.85));
		System.out.print(String.format("上面价格的指数表示：%e%n",50*0.85));
		System.out.print(String.format("上面价格的指数和浮点数结果的长度较短的是：%g%n",50*0.85));
		System.out.print(String.format("上面的折扣是%d%% %n",85));
		System.out.print(String.format("字母A的散列码是：%h%n",'A'));
		System.out.print(String.format("格式化参数S的使用:%1$d,%2$s",99,"abc"));
		System.out.print(String.format("显示正负数的符号:%+d与%d%n",99,-99));
		System.out.print(String.format("最牛的编号是:%03d%n",7));
		System.out.print(String.format("Tab键的效果是:% 8d%n",7));
		System.out.print(String.format("整数分组的效果是:%,d%n",9989997));
		System.out.print(String.format("一本书的价格是:%2.2f元%n",49.8));
		Date date=new Date();
		System.out.print(String.format("全部日期和时间信息:%tc%n",date));
		System.out.print(String.format("年-月-日格式:%tF%n",date));
		System.out.print(String.format("月/日/年格式:%tD%n",date));
		System.out.print(String.format("HH:MM:SS PM格式(12时制):%tr%n",date));
		System.out.print(String.format("HH:MM:SS格式()24时制:%tT%n",date));
		System.out.print(String.format("HH:MM:SS格式(24时制):%tR",date));
	}
}