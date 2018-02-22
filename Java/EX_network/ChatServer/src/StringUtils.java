
public class StringUtils {

	public static String getCode(String message) {
		String str="";
		/*String str2="";
		for(int i=0;str!=null;i++){
			str=message.split(" ")[i];
			if(str!=null&&!"".equals(str)){
				for(int j=0;j<str.length();j++){
					if(str.charAt(j)>=48&&str.charAt(j)<=57){
						str2+=str.charAt(j);
					}
				}
				}
			if(!"".equals(str2)){
				return str2;
			}
		}*/
		str=message.split("@")[0];
		System.out.println(str);
		if(!"".equals(str))return str;
		else return null;
	}

	public static String getContent(String message) {
		String str="";
		str=message.split("@")[1];
		System.out.println(str);
		if(!"".equals(str)){
			return str;
		}
		else return null;
	}

}
