using System;
namespace MyTest
{
     class Test
     {
         [STAThread]
         static void Main(string[] args)
         {
             int years = 100;     //定义变量年
             long seconds;         //定义变量秒
             long minutes;         //定义变量分钟
             long hours;         //定义变量小时
             hours = years * 365 * 24;
             minutes = hours * 60;
             seconds = hours * 60;
             Console.WriteLine("{0}年有{1}小时{2}分钟{3}秒", years, hours, minutes, seconds);
         }
     }
}