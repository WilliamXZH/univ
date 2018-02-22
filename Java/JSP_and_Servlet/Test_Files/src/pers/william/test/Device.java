package pers.william.test;

public class Device {
	public static String getDeviceSQL(int n,int m,int dvstoid[],int dvstyp[],double balance[]){
		//int n=dvs.length;
		//int cn=ids.length;
		
		String tmp="prompt Loading DEVICE...\r\n";
		
		for(int i=0;i<n;i++){
//			boolean flag=true;
//			while(flag){
//				flag=false;
//				dvs[i]=Utils.getRandomInt()%1000;
//				for(int j=0;j<i;j++){
//					if(dvs[i]==dvs[j]){
//						flag=true;
//						break;
//					}
//				}
//			}
			
			dvstyp[i]=1;
			
			if(i<m)dvstoid[i]=i+1;
			else dvstoid[i]=Utils.getRandomInt()%m+1;
			for(int j=0;j<i;j++){
				if(dvstoid[i]==dvstoid[j]){
					dvstyp[i]++;
				}
			}
			
			balance[i]=Double.parseDouble(Utils.getRandomDouble());
			tmp+="insert into DEVICE (deviceid, clientid, type, balance) values ("
					//+dvs[i]+","+dvstoid[i]+",\'"+Utils.IntToChar2(dvstyp[i])
					+(i+1)+","+dvstoid[i]+",\'"+Utils.IntToChar2(dvstyp[i])
					+"\',"+balance[i]+");\r\n";

			if(i%100==99)tmp+="commit;\r\n"
					+"prompt "+(i+1)+" records committed...\r\n";
			
		}
		
		
		return tmp;
	}
}
