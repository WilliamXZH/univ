using System;
namespace MyTest
{
     class Test
     {
         [STAThread]
         static void Main(string[] args)
         {
             int years = 100;     //���������
             long seconds;         //���������
             long minutes;         //�����������
             long hours;         //�������Сʱ
             hours = years * 365 * 24;
             minutes = hours * 60;
             seconds = hours * 60;
             Console.WriteLine("{0}����{1}Сʱ{2}����{3}��", years, hours, minutes, seconds);
         }
     }
}