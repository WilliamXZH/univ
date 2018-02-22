package pers.william.test;

public class Payfee {
	public static String getPayfee(int recnums[],int n,int month[],int day[],int dvsflag[][],
			int paycode[],int []bankcode,int dvstyp[],double receiv[][],
			String pay[],String[] bankname,String date[],String serial[]){
		int recnum=0;
		
		String tmp="prompt Loading PAYFEE...\r\n";

		String []banks={"中国银行","工商银行","建设银行","农业银行"
				,"招商银行","华夏银行","中信银行","交通银行"
				,"中央银行","民生银行","光大银行","恒丰银行","兴业银行"};
		String []banks2={"ZG","GS","JS","NY"
				,"ZS","HX","ZX","JT"
				,"ZY","MS","GD","GF","XY"};
		
		for(int j=0;j<12;j++){
			for(int i=0;i<n;i++){
				if(dvsflag[i][j]==1){
					int sub=Utils.getRandomInt()%bankcode.length;
					paycode[recnum]=bankcode[sub];
					
					month[recnum]=j+1;
					day[recnum]=Utils.getRandomInt()%28+1;
					date[recnum]="to_date(\'"+Utils.IntToChar2(day[recnum])+"-"+
							Utils.IntToChar2(month[recnum])+"-2016"+"\',\'dd-mm-yy\')";
		
					for(int x=0;x<banks.length;x++){
						if(bankname[sub].equals(banks[x])){
							serial[recnum]=banks2[x]+"2016"+
						Utils.IntToChar2(month[recnum])+Utils.IntToChar2(day[recnum])+
									"00"+Utils.IntToChar4(recnum);
							break;
						}
					}
					pay[recnum]=""+receiv[i][j];
					
					tmp+="insert into PAYFEE (id, deviceid, paymoney, paydate,"+
					" bankcode, type, bankserial)values ("+
							//+payid[i]+","+dvs[dvsid]+",\'"+pay[i]+"\',"+date[i]+
							+(recnum+1)+","+(i+1)+",\'"+pay[recnum]+"\',"+date[recnum]+
							",\'"+paycode[recnum]+"\',\'20"+Utils.IntToChar2(dvstyp[i])+"\',\'"+
							serial[recnum]+"\');\r\n";
		
					if(recnum%100==99)tmp+="commit;\r\n"
							+"prompt "+(recnum+1)+" records committed...\r\n";
					

					
					recnum++;
				}
			}
			

		}
		recnums[0]=recnum;
		return tmp;
	}
}
