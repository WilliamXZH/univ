package com.group3.util;

public class SendMessage {
	public static void sendMessageToPhone(String telNum,String message){
		
		System.out.println("telNum:"+telNum);
		System.out.println("您的短信验证码为："+message+",验证码需妥善保存请勿透漏给他人【宇哥购票中心】");
	}
	public static void sendMessageToMailBox(String mail,String message){
		//假装有这个方法
		System.out.println("Mail:"+mail);
		System.out.println("您的邮箱验证码为："+message+",验证码需妥善保存请勿透漏给他人【宇哥购票中心】");
	}
}
