package com.group3.util;

import java.util.Random;

import javax.xml.ws.BindingProvider;

import org.junit.Test;
import org.omg.CORBA.PUBLIC_MEMBER;

import com.group3.util.sms.Sms;
import com.group3.util.sms.SmsSoap;
import com.group3.util.sms.SubmitResult;

public class SMSer {

	//private static String url = "http://106.ihuyi.cn/webservice/sms.php?method=Submit";
	private static String account = "C73920801";
	private static String password =  "5cc5241de9aa9e2559c452ef5aa5ea1c";

	@Test
	public void Test(){
		//String code = VerificationCode.createVerificationCode(4);

		String code=new Integer(new Random().nextInt(9000)+1000).toString();
		System.out.println(code);
		System.out.println(submitCode("18512444764", code));
		
	}

	public static String submitCode(String telNum,String code){
		String msg = "您的验证码是：" + code +"。请不要把验证码泄露给其他人。";
		return submitMSG(telNum, msg);
	}
	
	public static String submitMSG(String telNum,String msg){
		Sms submit = new Sms();
		SmsSoap smsSoap = (SmsSoap)submit.getSmsSoap();
		System.out.println(((BindingProvider)smsSoap).toString());
		SubmitResult submitResult = smsSoap.submit(account, password, telNum, msg);
		
		System.out.println(submitResult);
		
		return submitResult.getMsg();
	}
}
