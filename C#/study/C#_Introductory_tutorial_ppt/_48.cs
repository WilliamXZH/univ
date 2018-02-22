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
				Console.WriteLine("请输入你的邮箱:");
				email=Console.ReadLine();
				Console.WriteLine("你的邮箱是{0}",email);
				Console.WriteLine("继续输入邮箱吗?");
				string input=Console.ReadLine();
				if(input.ToUpper()=="YES")continue;
				else break;

			}
		}
	}
}