package com.group3.util;

import org.junit.Test;

import com.group3.util.mailvalidity.ValidateEmailWebService;
import com.group3.util.mailvalidity.ValidateEmailWebServiceSoap;

public class TestMailExist {
		
	private static ValidateEmailWebService validateEmailWebService =
			new ValidateEmailWebService();
	private static ValidateEmailWebServiceSoap validateEmailWebServiceSoap = 
			(ValidateEmailWebServiceSoap)validateEmailWebService.getValidateEmailWebServiceSoap();
		
	@Test
	public void  testMail(){
		String mail="paile5373032@163.com";
		
		System.out.println(validateEmailWebServiceSoap);
		
		short r = testMail(mail);
		System.out.println(getTestInfo(r));
	}
	
	public static short testMail(String mail){
		return validateEmailWebServiceSoap.validateEmailAddress(mail);
	}
	
	public static short testMailPro(String mail, int port){
		return validateEmailWebServiceSoap.validateEmailAddressPro(mail, port);
		
	}
	
	public static String getTestInfo(short r){
		
		String result=null;
		switch(r){
		case 0:
			result="请重新验证";
			break;
		case 1:
			result="邮件地址合法";
			break;
		case 2:
			result="只是域名正确";
			break;
		case 3:
			result="一个未知错误";
			break;
		case 4:
			result="邮件服务器没有找到";
			break;
		case 5:
			result="电子邮件地址错误";
			break;
		case 6:
			result="免费用户验证超过数量(50次/24小时)";
			break;
		case 7:
			result="商业用户不能通过验证";
			break;
		default:
			result="some error occured!";
		}
		
		return result;
	}
	
/*	0 = 请重新验证；1 = 邮件地址合法；2 = 只是域名正确；3 = 一个未知错误；
			4 = 邮件服务器没有找到；5 = 电子邮件地址错误；
			6 = 免费用户验证超过数量（50次/24小时）；7 = 商业用户不能通过验证*/
	
}
