package pers.william.test;

public class Bank {
	public static String getBankSQL(int bankcode[],String bankname[]){	
		int n=bankcode.length;
		String tmp="prompt Loading BANK...\r\n";
		String []banks={"�й�����","��������","��������","ũҵ����"
				,"��������","��������","��������","��ͨ����"
				,"��������","��������","�������","�������","��ҵ����"};
		for(int i=0;i<n;i++){
			boolean flag=true;
			while(flag){
				flag=false;
				bankcode[i]=Utils.getRandomInt()%90+10;
				bankname[i]=banks[Utils.getRandomInt()%13];
				for(int j=0;j<i;j++){
					if(bankcode[i]==bankcode[j]||bankname[i]==bankname[j]){
						flag=true;
						break;
					}
				}
			}
			tmp+="insert into BANK (id, name, code) values ("
					+(i+1)+",\'"+bankname[i]+"\',\'"
					+bankcode[i]+"\');\r\n";
		}

		tmp+="commit;\r\n";
		tmp+="prompt "+n+" records loaded\r\n";
		return tmp;
	}
}
