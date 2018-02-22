import java.util.Random;
public class sixSquare
{
	public static void main(String[] args){
		sixSquare six=new sixSquare();
		conversion con=new conversion();
		/*String str="Thank you for your company for these years,Best wishes to you!How are you recently?";
		String ensix=six.encreptionBySix(str,5);
		System.out.println("ensix"+ensix);
		String constr=con.ConByWeight(ensix,2);
		System.out.println("constr:"+constr);
		String addstr=con.AddByWeight(constr,2);
		System.out.println("addstr:"+addstr);
		String desix=six.decreptionBySix(addstr);
		System.out.println("desix"+desix);*/

		//String str="decode by morse.";
		//String str="try each number add one,and you will understand the last message.";
		String str="I just want to cry when it comes to you!";
		String enstr=six.encreptionBySix(str,1);
		System.out.println("enstr:"+enstr);
		String constr=con.ConByWeight(enstr,2);
		System.out.println("constr:"+constr);
		String addstr=con.AddByWeight(constr,2);
		System.out.println("addstr:"+addstr);
		String destr=six.decreptionBySix(addstr);
		System.out.println("destr:"+destr);
	}
	public String encreptionBySix(String Message,int ratio){
		String result="";
		Message=Message.toLowerCase();
		Message=Message.replaceAll("[£¡,.;?!¡¢£¬¡££»£¿]",",");
		for(;Message.startsWith(",");)
			Message=Message.substring(1,Message.length());
		String []SubMessage=Message.split(",");
		for(int i=0;i<SubMessage.length;i++){
			result+="/";
			String[] SSMessage=SubMessage[i].split(" ");
			for(int j=0;j<SSMessage.length;j++){
				for(int k=0;k<SSMessage[j].length();k++){
					int random=(int)(Math.random()*ratio)%ratio;
					//System.out.println("Random:"+random);
					if(Character.isDigit(SSMessage[j].charAt(k))){
						result+=random*36+(int)(SSMessage[j].charAt(k)-'0'+26);
						if(k!=SSMessage[j].length()-1)result+=".";
					}else{
						result+=random*36+(int)(SSMessage[j].charAt(k)-'a'+1);
						if(k!=SSMessage[j].length()-1)result+=".";
					}
				}
				result+="/";
			}
			if(i!=SubMessage.length-1)result+=",";
		}
		return result;
	}
	public String decreptionBySix(String Message){
		String result="";
		for(;Message.startsWith(",");)
			Message=Message.substring(1,Message.length());
		String []SubMessage=Message.split(",");
		for(int i=0;i<SubMessage.length;i++){
			//System.out.println("SubMessage:"+SubMessage[i]);
			if(SubMessage[i].startsWith("/"))
				SubMessage[i]=SubMessage[i].substring(1,SubMessage[i].length());
			String[] SSMessage=SubMessage[i].split("/");
			for(int j=0;j<SSMessage.length;j++){
				//System.out.println("SSMessage:"+SSMessage[j]);
				if(!SSMessage[j].equals("")){
					String[] SSSMessage=SSMessage[j].split("\\.");
					for(int k=0;k<SSSMessage.length;k++){
						//System.out.println("SSSMessage:"+Integer.parseInt(SSSMessage[k]));
						int tmpNum=Integer.parseInt(SSSMessage[k])%36;
						if(tmpNum<=26)result+=(char)(tmpNum+'a'-1);
						else result+=(char)(tmpNum-26+'0');
					}
				}
				if(j!=SSMessage.length-1)
					result+=" ";
			}
			if(i!=SubMessage.length-1)result+=",";
		}
		return result;
	}
}