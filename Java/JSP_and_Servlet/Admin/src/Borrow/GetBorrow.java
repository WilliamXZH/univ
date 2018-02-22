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
		System.out.println("�������û���");
		name=new Scanner(System.in).next();
		System.out.println("����������");
		password=new Scanner(System.in).next();
		MannerUser mannerUser=new MannerUser();
		int i=mannerUser.login(name, password);
		if (i==1) {
			System.out.println("��½�ɹ�");
			Borrow();
		}
		else{
			System.out.println("��½ʧ��");
		}
	}
	@SuppressWarnings("resource")
	void Borrow(){
		MannerBookMenu mannerBookMenu=new MannerBookMenu();
		MannerBorrow mannerBorrow;
		BookMenu bookMenu;
		book_user.Borrow borrow;
		System.out.println("��������Ҫ����鼮��ţ�");
		bookID=new Scanner(System.in).nextInt();
		bookMenu=mannerBookMenu.borrowBook(bookID);
		if (bookMenu==null) {
			System.out.println("û�ҵ���Ҫ���鼮");
		}else{
			if (bookMenu.getLeft()==0) {
				System.out.println("��Ҫ���鼮��ȫ������ԤԼ��");
			}
			else{
				mannerBorrow=new MannerBorrow();
				Date x=new Date();
				java.sql.Date BorrowDate=new java.sql.Date(x.getTime());
				java.sql.Date ReturnDate=new  java.sql.Date(x.getTime()+(long)24*60*60*1000*30);
				borrow=new book_user.Borrow(bookMenu.getId(), bookMenu.getName(), name, BorrowDate, ReturnDate);
				if (mannerBorrow.addBorrow(borrow)==1) {
					System.out.println("����ʧ�ܣ����Ѿ��������");
				}
				else{
					mannerBookMenu.deleteBook(bookMenu);
					System.out.println("���ĳɹ�����30���黹����ͼ���");

				}
				
			}
		}
		

	}
}
