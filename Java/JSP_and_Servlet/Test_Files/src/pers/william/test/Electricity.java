package pers.william.test;

public class Electricity {
	public static String getElectricity(int n,int snum[][]){
		//int n=dvs.length;
		
		String tmp="prompt Loading ELECTRICITY...\r\n";

		for(int i=0;i<n;i++){
			for(int j=0;j<12;j++){	
				String date="2016"+Utils.IntToChar2(j+1);	
				if(j==0) snum[i][j]=Utils.getRandomInt()%1000;
				else snum[i][j]=snum[i][j-1]+Utils.getRandomInt()%1000;
				
				tmp+="insert into ELECTRICITY (id, deviceid, yearmonth, snum) values ("
						//+dvs[i]+","+dvs[i]+",\'"+date+"\',"
						+(i+j*n+1)+","+(i+1)+",\'"+date+"\',"
						+snum[i][j]+");\r\n";
				if((i*12+j)%100==99)tmp+="commit;\r\n"
						+"prompt "+(i*12+j+1)+" records committed...\r\n";
			}
		}
		
		return tmp;
	}
}
