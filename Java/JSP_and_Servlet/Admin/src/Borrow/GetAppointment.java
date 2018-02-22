package Borrow;

import java.util.Date;
import java.util.Scanner;
import java.util.Vector;

import MysqlManner.MannerAppointment;
import MysqlManner.MannerBorrow;
import MysqlManner.MannerUser;
import book_user.Appointment;

public class GetAppointment {
	String name;
	String password;
	@SuppressWarnings("resource")
	public GetAppointment(){
		System.out.println("请输入用户名\n");
		name=new Scanner(System.in).next();
		System.out.println("请输入密码\n");
		password=new Scanner(System.in).next();
		MannerUser mannerUser=new MannerUser();
		int i=mannerUser.login(name, password);
		if (i==1) {
			System.out.println("登陆成功");
			Borrow();
		}
		else{
			System.out.println("登陆失败");
		}
	}
	@SuppressWarnings("resource")
	void Borrow(){
		MannerAppointment mannerAppointment=new MannerAppointment();
		MannerBorrow mannerBorrow=new MannerBorrow();
		Vector<Appointment> vector=mannerAppointment.findAppointment(name);
		for(int i=0;i<vector.size();i++){
			Appointment appointment=vector.get(i);
			System.out.println(i+1+appointment.getName());
		}
		if (vector.isEmpty()==false) {
			System.out.println("请选择要借的书籍");
			int j=new Scanner(System.in).nextInt();
			if (j>0&&j<=vector.size()) {
				Appointment appointment=vector.get(j-1);
				Date x=new Date();
				java.sql.Date BorrowDate=new java.sql.Date(x.getTime());
				java.sql.Date ReturnDate=new  java.sql.Date(x.getTime()+(long)24*60*60*1000*30);
				book_user.Borrow borrow=new book_user.Borrow(appointment.getId(), appointment.getName(), name, BorrowDate, ReturnDate);
				mannerAppointment.deleteAppointment(appointment.getUser(), appointment.getId());
				mannerBorrow.addBorrow(borrow);
				System.out.println("借阅成功请在30天后归还至本图书馆");
			}
		}else {
			System.out.println("无预约书籍");

		}
		


	}
}
