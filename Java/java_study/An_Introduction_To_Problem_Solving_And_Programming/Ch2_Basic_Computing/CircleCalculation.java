import java.util.Scanner;

/**
  Program to compute area of a circle.
  Author: Jane Q. Programmer.
  E-mail Address: janeq@somemachine.etc.etc.
  Programming Assignment 2.
  Last Changed: October 7, 2008.
*/

public class CircleCalculation
{
	public static final double PI = 3.14159;

	public static void main(String[] args)
	{
		double radius;  //in inches
		double area;    //in square inches

		Scanner keyboard = new Scanner(System.in);

		System.out.println("Enter the radius of a circle in inches:");
		radius = keyboard.nextDouble();
		area = 3.14159 * radius * radius;//PI
		System.out.println("A circle of radius " + radius + " inches");
		System.out.println("has an area of " + area + " square inches.");
	}
}