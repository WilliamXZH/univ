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
		System.out.println("�������û���\n");
		name=new Scanner(System.in).next();
		System.out.println("����������\n");
		password=new Scanner(System.in).next();
		MannerUser mannerUser=new MannerUser();
		int i=mannerUser.login(name, password);
		if (i==1) {
			System.out.println("��½�ɹ�");
			returnBook();
		}
		else{
			System.out.println("��½ʧ��");
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
			System.out.println("��ѡ��Ҫ�����鼮");
			int j=new Scanner(System.in).nextInt();
			if (j>0&&j<=vector.size()) {
				Borrow borrow=vector.get(j-1);		
				mannerBorrow.deleteBorrow(borrow.getUser(), borrow.getBookId());
				mannerBookMenu.returnBook(mannerBookMenu.Search(borrow.getName()));
				System.out.println("�黹�ɹ�");
			}
		}else {
			System.out.println("���ѽ��鼮");

		}
	}
}
