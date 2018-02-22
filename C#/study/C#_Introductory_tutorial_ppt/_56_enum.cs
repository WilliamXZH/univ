using System;
class MyApp
{
	enum Fabric:int{
		Cotton=1,
		Silk=2,
		Wool=4
	}
	static void Main(){
		Fabric fab=Fabric.Cotton;
		int fabNum=(int)fab;
		string fabType=fab.ToString();
		Console.WriteLine(fab);
		Console.WriteLine(fabType);
	}
}