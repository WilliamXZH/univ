#include<iostream>
using namespace std;

class A
{
	public:
		void f(){cout<<"A"<<endl;}
};
class B:public A
{
	public:
		virtual void f(){cout<<"B"<<endl;}
};

int main(){
	A *a = new B;
	a->f();
}