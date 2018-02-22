public class reverse
{
	public static void main(String []args){

	}
	public int reverseInteger(int n){
		StringBuilder sb=new StringBuilder(new Integer(n).toString());
		if(n>0){
			String rsb=sb.reverse().toString();
			try{
				return new Integer(rsb);
			}catch(RuntimeException e){
				return 0;
			}else if(n<0){
				StringBuilder nsb=new StringBuilder(sb.substring(1));
				String ssb="-"+nsb.reverse().toString();
				try{
					return new Integer(ssb);
				}catch(RuntimeException e){
					return 0;
				}
			}else{
				return 0;
			}
		}
	}
}