import java.util.Scanner;

public class SpendingSpree
{
	public static final int SPENDING_MONEY = 100;
	public static final int MAX_ITEMS = 3;
	public static void main(String[] args)
	{
		Scanner keyboard = new Scanner(System.in);
		boolean haveMoney = true;
		int leftToSpend = SPENDING_MONEY;
		int totalSpent = 0;
		int itemNumber = 1;
		while (haveMoney && (itemNumber <= MAX_ITEMS))
		{
			System.out.println("You may buy up to " +
				(MAX_ITEMS - itemNumber + 1) +
				" items");
			System.out.println("costing no more than $" + 
				leftToSpend + ".");
			System.out.print("Enter cost of item #" +
				itemNumber + ":$");
			int itemCost = keyboard.nextInt();
			if (itemCost <= leftToSpend)
			{
				System.out.println("You may buy this item.");
				totalSpent = totalSpent + itemCost;
				System.out.println("You spent $" + totalSpent +
					" so far.");
				leftToSpend = SPENDING_MONEY - totalSpent;
				if (leftToSpend > 0)
				{
					itemNumber++;
				}else 
				{
					System.out.println("You are out of money.");
					haveMoney = false;
				}
			}else
			{
				System.out.println("You cannot buy that item.");
			}
			System.out.println("You spent $" + totalSpent + 
				", and are done shopping.");

		}
	}
}