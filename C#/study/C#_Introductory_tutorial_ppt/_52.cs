using System;
class Program
{
	static void Main(string []args){
		string name="����";
		Console.WriteLine("My name is "+name+", I am "+18);
		Console.WriteLine("My name is {0}, I am {1}",name ,18);

		String birthday="1993.03.28";
		int height=187;
		String bloodType="A";
		String planet="��ţ��";
		String favourFood="banana";
		string record=string.Format(
			"������{0}\n�������£�{1}\n��ߣ�{2}\nѪ�ͣ�{3}\n������{4}\n��ϲ����ʳ�{5}",
		name,birthday,height,bloodType,planet,favourFood
		);
		Console.WriteLine("\n������ĸ��˵�����");
		Console.WriteLine(record);

		string yi="һ";
		string er="��";
		string san="��";
		string word=string.Format("��{0}��{1}��{2}��{1}�⣬����{2}�ߣ���֪{0}{1}����{0}��{2}",yi,er,san);
		Console.WriteLine(word);
	}
}