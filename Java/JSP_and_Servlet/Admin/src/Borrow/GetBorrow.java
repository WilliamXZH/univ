package Borrow;

import java.util.Date;
import java.util.Scanner;

import MysqlManner.MannerBookMenu;
import MysqlManner.MannerBorrow;
import MysqlManner.MannerUser;
import book_user.BookMenu;

public class GetBorrow {
	String name;
	String password;
	int bookID;
	@SuppressWarnings("resource")
	public GetBorrow(){
		System.out.println("请输入用户名");
		name=new Scanner(System.in).next();
		System.out.println("请输入密码");
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
		MannerBookMenu mannerBookMenu=new MannerBookMenu();
		MannerBorrow mannerBorrow;
		BookMenu bookMenu;
		book_user.Borrow borrow;
		System.out.println("请输入您要借的书籍编号：");
		bookID=new Scanner(System.in).nextInt();
		bookMenu=mannerBookMenu.borrowBook(bookID);
		if (bookMenu==null) {
			System.out.println("没找到您要的书籍");
		}else{
			if (bookMenu.getLeft()==0) {
				System.out.println("您要的书籍已全部外借或预约中");
			}
			else{
				mannerBorrow=new MannerBorrow();
				Date x=new Date();
				java.sql.Date BorrowDate=new java.sql.Date(x.getTime());
				java.sql.Date ReturnDate=new  java.sql.Date(x.getTime()+(long)24*60*60*1000*30);
				borrow=new book_user.Borrow(bookMenu.getId(), bookMenu.getName(), name, BorrowDate, ReturnDate);
				if (mannerBorrow.addBorrow(borrow)==1) {
					System.out.println("借阅失败，你已经借过此书");
				}
				else{
					mannerBookMenu.deleteBook(bookMenu);
					System.out.println("借阅成功请在30天后归还至本图书馆");

				}
				
			}
		}
		

	}
}
