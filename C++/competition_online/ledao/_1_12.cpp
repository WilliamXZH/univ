#include<iostream>
using namespace std;

class ClassA
{
	public:
		ClassA(){printf("a");}
		~ClassA(){printf("~a");}
		void print(){printf("_a_");}
		virtual void func(){printf("ac");}
};

class ClassB:public ClassA
{
	//int x;
	public:
		ClassB(){printf("b");}
		~ClassB(){printf("~b");}
		void print(){printf("_b_");}
		void func(){printf("bc");}
};

int main()
{
	ClassA *a=new ClassB();
	a->func();
	//ClassB a;
	//a.func();
	cout<<sizeof(ClassA)<<endl;
	cout<<sizeof(ClassB)<<endl;
	a->print();
	delete a;
	return 0;
}