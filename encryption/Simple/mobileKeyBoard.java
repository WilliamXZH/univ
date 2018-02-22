public class mobileKeyBoard
{
	String []mobileLetter={"7412369456","14712365456987","3214789","1471236987",
		"4563214789","147123456","3214789569","147456369","123258789","12325874",
		"14735459","2589","1471585369","72583","236987412","147123654","12369874159",
		"14712365459","321456987","123258","1478963","14863","147525963","159357",
		"15358","1235789"
	};
	String []mobileDigit={"412369874","258","123654789","12365456987","2456258",
		"12314568987","3214789654","1258","1236547896541","6541236987"
	};
	public static void main(String[] args){
		mobileKeyBoard mo=new mobileKeyBoard();
		conversion con=new conversion();
		String str="If I love you,will you love me?";
		//String str="11111111111111";
		String enstr=mo.encreptionByMobile(str);
		String constr=con.ConByWeight(enstr,2);
		System.out.println("constr:"+constr);
		String addstr=con.AddByWeight(constr,2);
		System.out.println("addstr:"+addstr);
		String destr=mo.decreptionByMobile(addstr);
		System.out.println("destr:"+destr);
		
		//System.out.println(con.ConByWeight(str,16));
		//System.out.println(con.AddByWeight(con.ConByWeight(str,16),16));
	}
	public String encreptionByMobile(String Message){
		String result="";
		Message=Message.toLowerCase();
		Message=Message.replaceAll("[！,.;?!、，。；？]",",");
		//Message.replace('.',',');
		//System.out.println(Message);
		for(;Message.startsWith(",");)
			Message=Message.substring(1,Message.length());
		String []SubMessage=Message.split(",");
		for(int i=0;i<SubMessage.length;i++){
			//System.out.println(SubMessage[i]);
			result+="/";
			if(SubMessage[i].startsWith("\\s+"))
				SubMessage[i]=SubMessage[i].substring(1,SubMessage[i].length());
			String []SSMessage=SubMessage[i].split("\\s+");
			for(int j=0;j<SSMessage.length;j++){
				for(int k=0;k<SSMessage[j].length();k++){
					if(Character.isDigit(SSMessage[j].charAt(k)))
						result+=(mobileDigit[SSMessage[j].charAt(k)-'0']);
					else result+=(mobileLetter[SSMessage[j].charAt(k)-'a']);
					if(k!=SSMessage[j].length()-1)
						result+=".";
				}
				//if(j!=SSMessage.length-1)
				result+="/";
			}
			if(i!=SubMessage.length-1)result+=",";
		}
		return result;
	}
	public String decreptionByMobile(String Message){//低进制转换成高进制时会错误
		String result="";
		String[] SubMessage=Message.split(",");
		for(int i=0;i<SubMessage.length;i++){
			for(;SubMessage[i].startsWith("/");)
				SubMessage[i]=SubMessage[i].substring(1,SubMessage[i].length());
			//System.out.println("SubMessage[i]"+SubMessage[i]);
			String []SSMessage=SubMessage[i].split("/");
			for(int j=0;j<SSMessage.length;j++){
				//System.out.println("SSMessage[j]"+SSMessage[j]);
				String[] SSSMessage=SSMessage[j].split("\\.");
				for(int k=0;k<SSSMessage.length;k++){
					boolean flag=false;
					//System.out.println("SSSMessage[k]"+SSSMessage[k]);
					for(int rl=0;rl<mobileLetter.length;rl++){
						if(SSSMessage[k].equals(mobileLetter[rl])){
							flag=true;
							result+=(char)(rl+'a');
							break;
						}
					}
					if(flag==false){
						for(int rd=0;rd<mobileDigit.length;rd++){
							//System.out.println("Digit Test:"+SSSMessage[k]+","+mobileLetter[rd]);
							if(SSSMessage[k].equals(mobileDigit[rd])){
								//flag=true;
								//System.out.println((char)(rd+'0'));
								result+=(char)(rd+'0');
								break;
							}
						}
					}
					//if(k!=SSSMessage.length-1)result+=".";
				}
				if(j!=SSMessage.length-1)result+=" ";
			}
			if(i!=SubMessage.length-1)result+=",";
		}
		return result;
	}
}