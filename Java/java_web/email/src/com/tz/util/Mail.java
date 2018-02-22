package com.tz.util;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ClassName: Mail
 * @Description: 邮件群发核心类
 * @author Administrator
 * @date 2017年7月18日 下午10:01:12
 */
public class Mail extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String name = request.getParameter("m_name");//收件人
			String topic = request.getParameter("m_topic");
			String content = request.getParameter("m_con");//正文
			String username = "a_910984013@163.com";
			String password = "lanqiaov587";
			//创建一个工具用来读取邮箱的配置
			Properties props = new Properties();
			props.put("mail.transport.protcol", "smtp");//邮件传输协议
			props.put("mail.host", "smtp.163.com");//邮件主机
			props.put("mail.smtp.auth", true);//密码安全验证
			Session session = Session.getInstance(props);
			MimeMessage ms = new MimeMessage(session);
			Address toAddress;
			toAddress = new InternetAddress();
			//邮件的来源
			ms.setFrom(toAddress);
			ms.setRecipients(Message.RecipientType.TO, name);
			ms.setSubject(topic);
			ms.setText(content);
			ms.saveChanges();
			
			//创建发送工具
			Transport ts = session.getTransport();
			ts.connect(username,password);
			ts.sendMessage(ms, ms.getAllRecipients());
			ts.close();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		
		
		//super.service(arg0, arg1);
	}
	
}
