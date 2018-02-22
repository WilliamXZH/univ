using System;
class Program
{
	static void Main(string[] args)
	{
		string inputString;
		inputString=Console.ReadLine();
		inputString=inputString.Trim();
		string[] splitStrings=inputString.Split(' ');
		string joinString=string.Join("_",splitStrings);
		Console.WriteLine(joinString);
	}
}