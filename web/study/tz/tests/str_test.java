public class str_test
{
	public static void main(String []args){
		int k = 6;
		String str = "k="+k+"��������Ϊ";
		switch(k){
			case 1:
				str+= "һ";
				break;
			case 2:
				str+="��";
				break;
			case 3:
				str+="��";
				break;
			case 4:
				str+="��";
				break;
			case 5:
				str+="��";
				break;
//			default:
//				str="���ֳ�����";
//				break;
		}
		System.out.println(str);
	}
}