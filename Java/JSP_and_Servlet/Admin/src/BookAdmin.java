import java.util.Scanner;

import Borrow.GetAppointment;
import Borrow.GetBorrow;
import Return.ReturnBook;

public class BookAdmin {

	public static void main(String[] args) {
		int i=0;
		boolean b=true;
		while(b){
			System.out.println("东北大学图书馆管理员");
			System.out.println("1.借书");
			System.out.println("2.还书");
			System.out.println("3.退出");
			i=new Scanner(System.in).nextInt();
			switch (i) {
			case 1:
				borrow();
				break;
			case 2:
				returnn();
				break;
			case 3:
				b=false;
				break;
					

			default:
				break;
			}
		}
	}
	static void borrow(){
		System.out.println("1.直接借书");
		System.out.println("2.取预约书");
		@SuppressWarnings("resource")
		int i=new Scanner(System.in).nextInt();
		switch (i) {
		case 1:
			new GetBorrow();
			break;
		case 2:
			new GetAppointment();
		default:
			break;
		}
	}
	
	static void returnn(){
		new ReturnBook();
	}

}
