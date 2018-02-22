public class str_test
{
	public static void main(String []args){
		int k = 6;
		String str = "k="+k+"的中文字为";
		switch(k){
			case 1:
				str+= "一";
				break;
			case 2:
				str+="二";
				break;
			case 3:
				str+="三";
				break;
			case 4:
				str+="四";
				break;
			case 5:
				str+="五";
				break;
//			default:
//				str="数字超出五";
//				break;
		}
		System.out.println(str);
	}
}