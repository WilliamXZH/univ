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
 * @Description: �ʼ�Ⱥ��������
 * @author Administrator
 * @date 2017��7��18�� ����10:01:12
 */
public class Mail extends HttpServlet{
	
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			request.setCharacterEncoding("utf-8");
			response.setContentType("text/html;charset=utf-8");
			String name = request.getParameter("m_name");//�ռ���
			String topic = request.getParameter("m_topic");
			String content = request.getParameter("m_con");//����
			String username = "a_910984013@163.com";
			String password = "lanqiaov587";
			//����һ������������ȡ���������
			Properties props = new Properties();
			props.put("mail.transport.protcol", "smtp");//�ʼ�����Э��
			props.put("mail.host", "smtp.163.com");//�ʼ�����
			props.put("mail.smtp.auth", true);//���밲ȫ��֤
			Session session = Session.getInstance(props);
			MimeMessage ms = new MimeMessage(session);
			Address toAddress;
			toAddress = new InternetAddress();
			//�ʼ�����Դ
			ms.setFrom(toAddress);
			ms.setRecipients(Message.RecipientType.TO, name);
			ms.setSubject(topic);
			ms.setText(content);
			ms.saveChanges();
			
			//�������͹���
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
