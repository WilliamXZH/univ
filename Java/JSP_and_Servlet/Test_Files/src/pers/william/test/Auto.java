package pers.william.test;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

public class Auto {
	private static int Bank_Num=7;
	
	private static int Client_Num=100;
	
	private static int Device_Num=200;
	
	private static int Record_Num=Device_Num*12;
	
	private static String FilePathAndName="f:/DataInsertion.sql";
	
	
	public static void main(String[] args){
		String sql="prompt PL/SQL Developer import file\r\n"
				+"prompt Created on 2016Äê12ÔÂ5ÈÕ by Administrator\r\n"
				+"set feedback off\r\n"
				+"set define off\r\n"
				+"prompt Disabling triggers for BANK...\r\n"
				+"alter table BANK disable all triggers;\r\n"
				+"prompt Disabling triggers for BANKRECORD...\r\n"
				+"alter table BANKRECORD disable all triggers;\r\n"
				+"prompt Disabling triggers for CHECKRESULT...\r\n"
				+"alter table CHECKRESULT disable all triggers;\r\n"
				+"prompt Disabling triggers for CHECK_EXCEPTION...\r\n"
				+"alter table CHECK_EXCEPTION disable all triggers;\r\n"
				+"prompt Disabling triggers for CLIENT...\r\n"
				+"alter table CLIENT disable all triggers;\r\n"
				+"prompt Disabling triggers for DEVICE...\r\n"
				+"alter table DEVICE disable all triggers;\r\n"
				+"prompt Disabling triggers for ELECTRICITY...\r\n"
				+"alter table ELECTRICITY disable all triggers;\r\n"
				+"prompt Disabling triggers for PAYFEE...\r\n"
				+"alter table PAYFEE disable all triggers;\r\n"
				+"prompt Disabling triggers for RECEIVABLES...\r\n"
				+"alter table RECEIVABLES disable all triggers;\r\n"
				+"prompt Deleting RECEIVABLES...\r\n"
				+"delete from RECEIVABLES;\r\n"
				+"commit;\n"
				+"prompt Deleting PAYFEE...\r\n"
				+"delete from PAYFEE;\r\n"
				+"commit;\r\n"
				+"prompt Deleting ELECTRICITY...\r\n"
				+"delete from ELECTRICITY;\r\n"
				+"commit;\r\n"
				+"prompt Deleting DEVICE...\r\n"
				+"delete from DEVICE;\r\n"
				+"commit;\r\n"
				+"prompt Deleting CLIENT...\r\n"
				+"delete from CLIENT;\r\n"
				+"commit;\r\n"
				+"prompt Deleting CHECK_EXCEPTION...\r\n"
				+"delete from CHECK_EXCEPTION;\r\n"
				+"commit;\r\n"
				+"prompt Deleting CHECKRESULT...\r\n"
				+"delete from CHECKRESULT;\r\n"
				+"commit;\r\n"
				+"prompt Deleting BANKRECORD...\r\n"
				+"delete from BANKRECORD;\r\n"
				+"commit;\r\n"
				+"prompt Deleting BANK...\r\n"
				+"delete from BANK;\r\n";
		
		int bankcode[]=new int[Bank_Num];
		String bankname[]=new String[Bank_Num];
		
		//int clientid[]=new int[Client_Num];
		//int device[]=new int[Device_Num];
		int dvstyp[]=new int [Device_Num];
		int dvstoid[]=new int[Device_Num];
		double balances[]=new double[Device_Num];
		
		int snums[][]=new int[Device_Num][12];
		
		double receiv[][]=new double[Device_Num][12];
		int dvsflag[][]=new int[Device_Num][12];
		
		//int payid[]=new int[Record_Num];
		int paycode[]=new int[Record_Num];
		int month[]=new int[Record_Num];
		int day[]=new int[Record_Num];
		String pay[]=new String[Record_Num];
		String date[]=new String[Record_Num];
		String[] serial=new String[Record_Num];
		
		
		sql+=Bank.getBankSQL(bankcode,bankname);
		//sql+=Client.getClientSQL(clientid);
		sql+=Client.getClientSQL(Client_Num);
		sql+=Device.getDeviceSQL(Device_Num,Client_Num, dvstoid,dvstyp,balances);
		sql+=Electricity.getElectricity(Device_Num,snums);
		sql+=Receivables.getReceivablesSQL(Device_Num,dvstyp,snums,receiv,dvsflag);
		
		int paynums[]=new int [2];
		sql+=Payfee.getPayfee(paynums,Device_Num,month,day,dvsflag,paycode,
				bankcode,dvstyp,receiv,pay,bankname,date,serial);
		
		sql+=BankRecord.getBankRecordSQL(paynums[0],paycode,pay,serial);
		//sql+=CheckResult.getChectResult(paynums[0],paycode,bankcode, month,day,pay);
		
		sql+="prompt Enabling triggers for BANK...\r\n"
			+"alter table BANK enable all triggers;\r\n"
			+"prompt Enabling triggers for BANKRECORD...\r\n"
			+"alter table BANKRECORD enable all triggers;\r\n"
			+"prompt Enabling triggers for CHECKRESULT...\r\n"
			+"alter table CHECKRESULT enable all triggers;\r\n"
			+"prompt Enabling triggers for CHECK_EXCEPTION...\r\n"
			+"alter table CHECK_EXCEPTION enable all triggers;\r\n"
			+"prompt Enabling triggers for CLIENT...\r\n"
			+"alter table CLIENT enable all triggers;\r\n"
			+"prompt Enabling triggers for DEVICE...\r\n"
			+"alter table DEVICE enable all triggers;\r\n"
			+"prompt Enabling triggers for ELECTRICITY...\r\n"
			+"alter table ELECTRICITY enable all triggers;\r\n"
			+"prompt Enabling triggers for PAYFEE...\r\n"
			+"alter table PAYFEE enable all triggers;\r\n"
			+"prompt Enabling triggers for RECEIVABLES...\r\n"
			+"alter table RECEIVABLES enable all triggers;\r\n"
			+"set feedback on\r\n"
			+"set define on\r\n"
			+"prompt Done.\r\n";
		
		

		File file=new File(FilePathAndName);
		if(!file.exists()){
			try{
				file.createNewFile();
			}catch(IOException e){
				e.printStackTrace();
			}
		}
		byte bytes[];
		try {
			bytes = sql.getBytes("utf-8");
		OutputStream out;
		try {
			out = new FileOutputStream(file);
		try {
			out.write(bytes);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			out.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			out.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		System.out.println(sql);
		
		

	}
}
