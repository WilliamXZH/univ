package Return;
import java.util.Scanner;
import java.util.Vector;
import MysqlManner.MannerBookMenu;
import MysqlManner.MannerBorrow;
import MysqlManner.MannerUser;
import book_user.Borrow;

public class ReturnBook {
	String name;
	String password;
	@SuppressWarnings("resource")
	public ReturnBook(){
		System.out.println("请输入用户名\n");
		name=new Scanner(System.in).next();
		System.out.println("请输入密码\n");
		password=new Scanner(System.in).next();
		MannerUser mannerUser=new MannerUser();
		int i=mannerUser.login(name, password);
		if (i==1) {
			System.out.println("登陆成功");
			returnBook();
		}
		else{
			System.out.println("登陆失败");
		}
	}
	@SuppressWarnings("resource")
	void returnBook(){
		MannerBorrow mannerBorrow=new MannerBorrow();
		MannerBookMenu mannerBookMenu=new MannerBookMenu();
		Vector<Borrow> vector=mannerBorrow.findBorrow(name);
		for(int i=0;i<vector.size();i++){
			Borrow borrow=vector.get(i);
			System.out.println(i+1+borrow.getName());
		}
		if (vector.isEmpty()==false) {
			System.out.println("请选择要还的书籍");
			int j=new Scanner(System.in).nextInt();
			if (j>0&&j<=vector.size()) {
				Borrow borrow=vector.get(j-1);		
				mannerBorrow.deleteBorrow(borrow.getUser(), borrow.getBookId());
				mannerBookMenu.returnBook(mannerBookMenu.Search(borrow.getName()));
				System.out.println("归还成功");
			}
		}else {
			System.out.println("无已借书籍");

		}
	}
}
