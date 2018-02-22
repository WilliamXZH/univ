package others;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;
import java.util.Random;
import java.util.Scanner;

public class Course {
	private static String code="GBK";
	public static void main(String[] args){
		Random random=new Random();
		while(true){
			try{
				double time=Math.random();
				//int t=(int)(time*1000000000);
				//int t=random.nextInt();
				String login="GET http://202.118.31.243:8080/LOGIN_LOGININ.XKAPPPROCESS?Time=13123&strStudentNO=20134797&strPassword=181818";
				String choose="POST /XK_SELECTCOURSE.XKAPPPROCESS?Time=11111&XKTaskID=452573";
				Socket s=new Socket("202.118.31.243",8080);
				OutputStreamWriter osw=new OutputStreamWriter(s.getOutputStream());
				StringBuffer sb=new StringBuffer();
				sb.append("GET /LOGIN_LOGININ.XKAPPPROCESS?Time="+time+"&XKTaskID=452573\r\n"
						+"host: 202.118.31.243:8080\r\n"
						+"Connection: keep-alive\r\n"
						//+"Upgrade-Insecure-Requests: 1\r\n"
						+"Referer: http://202.118.31.243:8080/XK_LOGININCOMMIT.XKAPPPROCESS?Time="+Math.random()+"&strStudentNO=20134797&strPassword=181818\r\n"
						//+"Cookie: JSESSIONID=X8Hh5yUXx7uKGtlUUenvbkm1OQl7rRiMo9zfI3BakvOI7jXtMrJE!1119174361\r\n\n"
						);
				/*sb.append("POST /LOGIN_LOGININ.XKAPPPROCESS?Time="+t+"&strStudentNO: 20134797&strPassword=181818\r\n"
						+"POST /XK_SELECTCOURSE.XKAPPPROCESS?Time=11111&XKTaskID=452573"
						);
				osw.write(sb.toString());*/
				/*osw.write(new StringBuffer(login).toString());
				osw.write(new StringBuffer(choose).toString());
				osw.write(new StringBuffer("GET http://202.118.31.243:8080/XK_SELECTCOURSE.XKAPPPROCESS?Time=11111&XKTaskID=452502\r\n"+"host: 202.118.31.243:8080\r\nConnection: keep-alive\r\n").toString());
				System.out.println(new BufferedReader(new InputStreamReader(s.getInputStream())));
	            BufferedReader results = new BufferedReader(new InputStreamReader(s.getInputStream()));
	            String str;
	            while((str = results.readLine()) != null) {
	                    System.out.println(str);
	             }*/
	            osw.write(sb.toString());
	            System.out.println(sb.toString());
				//System.out.print(login+"\t"+choose+"\n");
				Thread.sleep(5000);
				s.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
	}
}
