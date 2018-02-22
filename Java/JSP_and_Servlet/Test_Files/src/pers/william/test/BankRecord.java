package pers.william.test;

public class BankRecord {
	public static String getBankRecordSQL(int n,int paycode[],String pay[],String serial[]){
		String tmp="prompt Loading BANKRECORD...\r\n";
		
		for(int i=0;i<n;i++){
			tmp+="insert into BANKRECORD (id, payfee, bankcode, bankserial)"+
		"values ("+(i+1)+","+pay[i]+",\'"+paycode[i]+"\',\'"+serial[i]+"\');\r\n";

			if(i%100==99)tmp+="commit;\r\n"
			+"prompt "+(i+1)+" records loaded\r\n";
		}
		
		return tmp;
	}
}
