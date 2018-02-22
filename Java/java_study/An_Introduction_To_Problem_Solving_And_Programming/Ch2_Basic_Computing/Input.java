//this class belongs to sixth problem in program practice.

import java.util.Scanner;

public class Input
{
	public static void main(String[] args)
	{
		Scanner keyboard = new Scanner(System.in);
		int age;
		String name;
		System.out.println("Enter your age.");
		age = keyboard.nextInt();
		System.out.println("Enter your full name.");
		keyboard.nextLine();//add this line.
		name = keyboard.nextLine();
		name = name.toUpperCase();//old:name.toUpperCase();
		System.out.println("Your name in uppercase is " + name +
			" and you are " + age + " years old." );
	}
}