package check;

import java.util.Scanner;

public class Main {
	static Scanner sc = new Scanner(System.in);
	public static void main(String args[]){
		CheckingAccount one=new CheckingAccount();
		Main main=new Main();
		while(true){
			int input=main.menu();
			switch(input){
			case 1:
				main.Trans(one);
				break;
			case 2:
				System.out.println(one.ListAll(0));
				break;
			case 3:
				System.out.println(one.ListAll(2));
				break;
			case 4:
				System.out.println(one.ListAll(1));
				break;
			default:
				System.out.println("Invalid input:"+input);
			}
			
		}
	}
	int menu(){
		System.out.println("1)���뽻��");
		System.out.println("2)���н����б�");
		System.out.println("3)����֧���б�");
		System.out.println("4)���д���б�");
		return Integer.parseInt(sc.next());
	}
	void Trans(CheckingAccount one){
		System.out.println("1)ȡ��");
		System.out.println("2)���");
		int choice=Integer.parseInt(sc.next());
		System.out.println("���׶�");
		double amt=Double.parseDouble(sc.next());
		one.check(choice,amt);
		/*if(choice==1){
			one.Draw();
		}
		else if(choice==2){
			one.Deposit();
		}
		else System.out.println("Invalid input:"+choice);*/
	}
}
