package pers.william.test;

public class Receivables {
	public static String getReceivablesSQL(int n,int type[],int snum[][],double receiv[][],int dvsflag[][]){
		//int n=dvs.length;
		
		String tmp="prompt Loading RECEIVABLES...\r\n";

		//String date="2016"+Utils.IntToChar2(Utils.getRandomInt()%6+1);
		
		for(int i=0;i<n;i++){
			int to=Utils.getRandomInt()%12+1;
			for(int j=0;j<12;j++){
				int id=i+j*n+1;
				String date="2016"+Utils.IntToChar2(j+1);
				
				if(type[i]==1){
					if(j==0)
						receiv[i][j]=snum[i][j];
					else receiv[i][j]=snum[i][j]-snum[i][j-1];
				}
				else{

					if(j==0)
						receiv[i][j]=snum[i][j];
					else receiv[i][j]=snum[i][j]-snum[i][j-1];
				}
				
				if(j<to)
					dvsflag[i][j]=1;
				else dvsflag[i][j]=0;
				
				tmp+="insert into RECEIVABLES (id, yearmonth, deviceid, basicfee, flag)"
						//+"values ("+i+",\'"+date+"\',"+dvs[i]+", "+Utils.getRandomInt()%300
						+"values ("+id+",\'"+date+"\',"+(i+1)+", "+receiv[i][j]
						+", \'"+dvsflag[i][j]+"\');\r\n";
	
				if(id%100==99)tmp+="commit;\r\n"
						+"prompt "+(id+1)+" records committed...\r\n";
			}
		}	
		return tmp;
	}
}
