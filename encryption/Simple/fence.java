public class fence{
	public static void main(String[] args){
		fence fen=new fence();
		sixSquare six=new sixSquare();
		conversion con=new conversion();
		//String str="abcdefg!hijklmn@opq#rst$uvw%xyz^12345&67890*";
		String str="Wan Qian Xin Yu,Shui Zhi Qi Xiang.Wei Er Ji Jing,Qing Sheng Yong Chuan.";
		System.out.println("str:"+str);
		String fenstr=fen.encreptionByFence(str,5);
		System.out.println("fenstr:"+fenstr);
		String ensix=six.encreptionBySix(fenstr,5);
		System.out.println("ensix:"+ensix);
		String constr=con.ConByWeight(ensix,2);
		System.out.println("constr:"+constr);
		String addstr=con.AddByWeight(constr,2);
		System.out.println("addstr:"+addstr);
		String desix=six.decreptionBySix(addstr);
		System.out.println("desix:"+desix);
		System.out.println("destr:"+fen.decreptionByFence(desix,5));
	}
	public String encreptionByFence(String Message,int fenNum){
		String result="";
		int length=Message.length();
		int aveNum=length/fenNum;
		//int aveNum=(length%fenNum==0?length/fenNum:length/fenNum+1);
		//for(int i=0;i<aveNum;i++){
		for(int i=0;i<(length%fenNum!=0?aveNum+1:aveNum);i++){
			//for(int j=0;j<(length%fenNum!=0&&i==aveNum-1?length%fenNum:aveNum);j++){
			for(int j=0;j<fenNum&&i*fenNum+j<length;j++){
				//for(int j=0;(length%fenNum==0?aveNum*j:(j<=length%fenNum?(aveNum+1)*j:((aveNum+1)*(length%fenNum)+aveNum*(j-length%fenNum))))+i<length;j++){
				//System.out.println(result);
				result+=Message.charAt((length%fenNum==0?aveNum*j:(j<=length%fenNum?(aveNum+1)*j:((aveNum+1)*(length%fenNum)+aveNum*(j-length%fenNum))))+i);
			}
		}
		return result;
	}
	public String decreptionByFence(String Message,int fenNum){
		String result="";
		int length=Message.length();
		for(int i=0;i<fenNum;i++){
			for(int j=0;j<(i>=length%fenNum?length/fenNum:length/fenNum+1);j++){
				result+=Message.charAt(j*fenNum+i);
			}
		}
		return result;
	}
}