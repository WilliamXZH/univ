using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace _011
{
	class Program
	{
		static void Main(string[] args)
		{
			while(true)
			{
				string email;
				Console.WriteLine("�������������:");
				email=Console.ReadLine();
				Console.WriteLine("���������{0}",email);
				Console.WriteLine("��������������?");
				string input=Console.ReadLine();
				if(input.ToUpper()=="YES")continue;
				else break;

			}
		}
	}
}