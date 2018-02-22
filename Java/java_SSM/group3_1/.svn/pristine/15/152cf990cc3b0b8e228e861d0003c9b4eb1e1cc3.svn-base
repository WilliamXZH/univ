package com.group3.util.smtp;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.lang.ObjectUtils.Null;
import org.junit.Test;

import com.group3.util.VerificationCode;

public class MailSenderOf163 {
	
	
	@Test
	public void test(){
		String code = VerificationCode.createVerificationCode(6);
		sendVerificationCode("615852611@qq.com", code);
	}
	
	private static Session session = null;
	private static Transport ts = null;
	
	private static void initial(){
			Properties prop=new Properties();
			prop.put("mail.host","smtp.163.com" );
			prop.put("mail.transport.protocol", "smtp");
			prop.put("mail.smtp.auth", true);
			//创建sesssion
			session=Session.getInstance(prop);
			//开启session的调试模式，可以查看当前邮件发送状态
			session.setDebug(true);

			try {
				//通过session获取Transport对象（发送邮件的核心API）
				ts = session.getTransport();
				//通过邮件用户名密码链接
				ts.connect("dilud19937", "group3");
			} catch (NoSuchProviderException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
	}
	
	private static Message getMessage(String mail,String content) throws MessagingException{
		
		initial();
		//创建邮件对象
		Message msg =new MimeMessage(session);
		
		//msg.setHeader("X-Mailer", "Microsoft Outlook Express 6.00.2900.2869");
		
		//设置发件人
		msg.setFrom(new InternetAddress("dilud19937@163.com"));
		//设置收件人
		msg.setRecipient(Message.RecipientType.TO, new InternetAddress(mail));
		//设置抄送人
		//mm.setRecipient(Message.RecipientType.CC, new InternetAddress("用户名@163.com"));

		msg.setSubject("VerificationCode");
		msg.setContent(content, "text/html;charset=utf-8");

		return msg;
	}
	
	public static void sendVerificationCode(String mail,String code){
		String content = "This is your verification code: <b>"+code+" </b>,please ignore if it not belongs to you!";
		sendContent(mail,content);
	}
	
	public static void sendContent(String mail,String content){
		try {
			sendMessage(getMessage(mail,content));
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	public static void sendMessage(Message msg) {
		try {
			//发送电子邮件
				ts.sendMessage(msg, msg.getAllRecipients());
		} catch (NoSuchProviderException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		}
	}
	
}
