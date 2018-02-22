using System;
class Program
{
	static void Main(string []args){
		string name="李四";
		Console.WriteLine("My name is "+name+", I am "+18);
		Console.WriteLine("My name is {0}, I am {1}",name ,18);

		String birthday="1993.03.28";
		int height=187;
		String bloodType="A";
		String planet="金牛座";
		String favourFood="banana";
		string record=string.Format(
			"姓名：{0}\n出生年月：{1}\n身高：{2}\n血型：{3}\n星座：{4}\n最喜欢的食物：{5}",
		name,birthday,height,bloodType,planet,favourFood
		);
		Console.WriteLine("\n这是你的个人档案：");
		Console.WriteLine(record);

		string yi="一";
		string er="二";
		string san="三";
		string word=string.Format("独{0}无{1}，{2}心{1}意，垂涎{2}尺，略知{0}{1}，举{0}反{2}",yi,er,san);
		Console.WriteLine(word);
	}
}