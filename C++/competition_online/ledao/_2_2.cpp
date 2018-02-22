#include<iostream>
using namespace std;

class C_1
{
	void fun(){}
};

class C_2
{
	virtual void fun()=0;
};

//#pragma pack(2)
class C_3
{
	char name[5];
	int score;
	short grade;
};
//#pragma pack()

#pragma pack(4)
class C_4
{
	char name[5];
	int score;
	short grade;
};
#pragma pack()

class C_5
{
	public:
		virtual void fun(){}
		static int data;
};

class C_6
{
	public:
		static void fun(){}
		int data;
};

class C_7:public C_5
{
	void fun(){}
	int data;
};

class C_8:public C_6
{
	void fun(){}
	static int data;
};



int main()
{
	cout<<sizeof(C_1)<<endl;
	cout<<sizeof(C_2)<<endl;
	cout<<sizeof(C_3)<<endl;
	cout<<sizeof(C_4)<<endl;
	cout<<sizeof(C_5)<<endl;
	cout<<sizeof(C_6)<<endl;
	cout<<sizeof(C_7)<<endl;
	cout<<sizeof(C_8)<<endl;
}