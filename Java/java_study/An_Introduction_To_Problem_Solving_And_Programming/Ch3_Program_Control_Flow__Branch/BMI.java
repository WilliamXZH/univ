import java.util.Scanner;

public class BMI
{
	public static void main(String[] args)
	{
		Scanner keyboard = new Scanner(System.in);
		int pounds, feet, inches;
		double heightMeters, mass, BMI;

		System.out.println("Enter your weight in pounds.");
		pounds = keyboard.nextInt();
		System.out.println("Enter your height in feet followed");
		System.out.println("by a space then additional inches.");
		feet = keyboard.nextInt();

		inches = keyboard.nextInt();

		heightMeters = ((feet * 12) + inches) * 0.0254;
		mass = (pounds / 2.2);
		BMI = mass / (heightMeters * heightMeters);

		System.out.println("Your BMI is " + BMI);
		System.out.print("Your risk category is ");
		if (BMI < 18.5)
		{
			System.out.println("Underweight.");
		}else if (BMI < 25)
		{
			System.out.println("Normal weight");
		}else if (BMI < 30)
		{
			System.out.println("Overweight.");
		}else
		{
			System.out.println("Obese.");
		}
	}
}