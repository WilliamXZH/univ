package pers.william.test;

public class CheckResult {
	public static String getChectResult(int n,int paycode[],int bankcode[],
			int month[],int day[],String pay[]){		
		String tmp="prompt Loading CheckResult...\r\n";

		for(int i=0;i<bankcode.length;i++){
			for(int j=1;j<=12;j++){
				for(int k=1;k<=28;k++){						
					int totalcount=0;
					double totalmoney=0;
					for(int x=0;x<n;x++){
						//System.out.println("???");
						if(paycode[x]==bankcode[i]&&month[x]==j&&day[x]==k){
							totalcount++;
							totalmoney+=Double.parseDouble(pay[j]);
						}
						
					}
					int id=i*12*28+(j-1)*28+k;
					String date="to_date(\'"+Utils.IntToChar2(k)+"-"+
							Utils.IntToChar2(j)+"-2016"+"\',\'dd-mm-yy\')";
					tmp+="insert into CHECKRESULT (id,checkdate, bankcode,banktotalcount,"+
					"banktotalmoney, ourtalcount,ourtotalmoney) values ("+
							+id+",\'"+date+"\',"+bankcode[i]+","+totalcount+","
					+totalmoney+","+totalcount+","+totalmoney+");\r\n";
		
					if(id%100==99)tmp+="commit;\r\n"
							+"prompt "+(id+1)+" records committed...\r\n";
					
					//System.out.println("id_checkdate_bankcode_count_money:"+id+"_"
					//		+date+"_"+bankcode[i]+"_"+totalcount+"_"+totalmoney);
				}
			}
		}

		tmp+="commit;\r\n"
				+"prompt "+(bankcode.length*12*28)+" records committed...\r\n";
		
		return tmp;
	}
}
