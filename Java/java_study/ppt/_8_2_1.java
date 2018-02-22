public class _8_2_1
{
	public static void main(String []args){
		String str="mingrikeji";
		int rs=str.indexOf('i');
		System.out.println("字符i首次出现的位置是:"+rs);
		rs=str.lastIndexOf('i');
		System.out.println("字符i最后一次出现的位置是:"+rs);
		rs=str.lastIndexOf("ri");
		System.out.println("字符串ri首次出现的位置是:"+rs);
		rs=str.lastIndexOf('1','4');
		System.out.println("从第5个字符后，字符i首次出现的位置是:"+rs);
		String substr=str.substring(0,6);
		System.out.println(substr);
		String str2="  公司地址：明日科技  ";
		str2=str2.replace("地址","名称");
		str2=str2.trim();
		System.out.println(str2);
		String str3="公司名称:明日科技！公司所在城市：长春市。公司电话：84972266";
		String[] info=null;
		info=str3.split("！|。");
		for(int i=0;i<info.length;i++){
			System.out.println(info[i]);
		}
	}
}