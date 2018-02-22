#include<iostream>
using namespace std;
class A
{
	public:
		A(void){output();}
		virtual void output(void){cout<<"A";}
};
class B:public A
{
	public:
		B(void):A(){output();}
		void output(){cout<<"B";}
};
void main()
{
	B b;
}