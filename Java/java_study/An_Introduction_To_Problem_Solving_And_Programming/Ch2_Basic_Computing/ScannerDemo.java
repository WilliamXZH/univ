import java.util.Scanner;

public class ScannerDemo
{
	public static void main(String[] args)
	{
		Scanner scannerObject = new Scanner(System.in);

		System.out.println("Enter two whole numbers");
		System.out.println("separated by one or more spaces:");

		int n1, n2;
		n1 = scannerObject.nextInt();
		n2 = scannerObject.nextInt();
		System.out.println("You entered " + n1 + " and " + n2);

		System.out.println("Next enter two numbers.");
		System.out.println("A decimal point is OK.");

		double d1, d2;
		d1 = scannerObject.nextDouble();
		d2 = scannerObject.nextDouble();
		System.out.println("You entered " + d1 + " and " + d2);

		System.out.println("Next enter two words:");

		String s1, s2;
		s1 = scannerObject.next();
		s2 = scannerObject.next();
		System.out.println("You entered \"" + s1 + "\" and \"" + s2 + "\"");

		s1 = scannerObject.nextLine();//To get rid of '\n'

		System.out.println("Next enter a line of text:");
		s1 = scannerObject.nextLine();
		System.out.println("You entered: \"" + s1 + "\"");
	}
}