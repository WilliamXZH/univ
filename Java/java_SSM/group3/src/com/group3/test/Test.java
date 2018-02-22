package com.group3.test;

import com.group3.util.VerificationCode;
import com.group3.util.smtp.MailSenderOf163;

public class Test {

	public void test(){

		String code = VerificationCode.createVerificationCode(6);
		//MailSenderOf163.sendVerificationCode("paile5373032@163.com", code);
		MailSenderOf163.sendVerificationCode("1146283602@qq.com", "阿萨德撒");
	}
	
	@org.junit.Test
	public void syso(){
		System.out.println("/3//2//1/");
	}
}
