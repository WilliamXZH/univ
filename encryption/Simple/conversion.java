import java.math.BigInteger;
public class conversion
{
	/*public static void main(String[] args){
		conversion con=new conversion();
		String str="127.24.33/,/51.66.13";
		System.out.println(con.conver(str,2,8));
		//System.out.println(str);
		//System.out.println(con.ConByWeight(str,16));
		//System.out.println(con.AddByWeight(con.ConByWeight(str,16),16));
	}*/
	public String AddByWeight(String Letter,int Weight){
		return conver(Letter,10,Weight);
	}
	public String ConByWeight(String Letter,int Weight){
		return conver(Letter,Weight,10);
	}
	public String conver(String Letter,int toWeight,int fromWeight){
		String result="";
		//System.out.println("\n"+Letter+"\n\n");
		for(;Letter.startsWith(",");)
			Letter=Letter.substring(1,Letter.length());
		String []SubMessage=Letter.split(",");
		for(int h=0;h<SubMessage.length;h++){
			//System.out.println("SubMessage:"+SubMessage[h]);
			result+="/";
			if(SubMessage[h].startsWith("/"))
				SubMessage[h]=SubMessage[h].substring(1,SubMessage[h].length());
			String []SSMessage=SubMessage[h].split("/");
			for(int i=0;i<SSMessage.length;result+="/",i++){
				//System.out.println("SSMessage:"+SSMessage[i]);
				if(SSMessage[i].equals(""))continue;
				if(SSMessage[i].startsWith("\\."))
					SSMessage[i]=SSMessage[i].substring(1,SSMessage[i].length());
				String []SSSMessage=SSMessage[i].split("\\." );
				int length=SSSMessage.length;
				for(int j=0;j<length;j++){
					//int CurrentNum=Integer.parseInt(SSSMessage[i]);//abandon
					//System.out.println("CurrentNum:"+SSSMessage[j]);
					String CurrentNum=SSSMessage[j];
					result+=SubConver(CurrentNum,toWeight,fromWeight);
					if(j!=length-1)result+='.';
				}
			}
			if(h!=SubMessage.length-1)result+=",";
		}
		return result;
	}
	public String SubConver(String x,int m,int n){
		String result="";
		Long tmp=0L;
		if(n!=10){
			int length=x.length();
			for(int i=0;i<length;i++){
				if(Character.isDigit(x.charAt(i))){
					//System.out.println(((long)Math.pow(n,length-i-1))*(x.charAt(i)-'0'));
					tmp+=((long)Math.pow(n,length-i-1))*(x.charAt(i)-'0');
				}
				else tmp+=((long)Math.pow(n,length-i-1))*(x.charAt(i)-'a'+10);
			}
			if(m==10)return Long.toString(tmp);
			//String s=String.valueOf(i);
			//String s=Integer.toString(i);
			//String s=""+i;
		}else tmp=Long.parseLong(x);
		for(;tmp!=0;tmp/=m){
			long remainder=tmp%m;
			if(Math.abs(remainder)<10)result=remainder+result;
			else result=(char)('a'+remainder-10)+result;
		}
		return result;
	}
}