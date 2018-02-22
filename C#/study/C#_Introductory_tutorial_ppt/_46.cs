using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
namespace _011
{
	class Program
	{
		static void Main(string[] args){
			string filename=@"1.2.txt";
			int indexDot=filename.LastIndexOf('.');
			string extendName="dat";
			filename=filename.Substring(0,indexDot+1);
			filename+=extendName;
			Console.WriteLine(filename);
		}
	}
}