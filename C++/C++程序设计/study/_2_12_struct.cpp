#include<iostream>
#include<iomanip>
using namespace std;

struct student
{
	int num;
	char name[20];
	char sex;
	int age;
}stu={97001,"Lin Lin",'F',19};

int main()
{
	cout<<setw(7)
		<<stu.num<<setw(20)<<stu.name<<setw(3)<<stu.sex<<setw(3)<<stu.age;
}