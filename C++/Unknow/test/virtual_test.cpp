#include<iostream>
using namespace std;

class A
{
	public:
		virtual int a;
		A(){}
		A(int t):a(t){}
		void f(){cout<<"A:"<<(this->a)<<endl;}
};

class B:public A
{
	public:
		int a;
		B(){}
		B(int t):A(t),a(t+1){}
		void f(){cout<<"B:"<<(this->a)<<endl;}
};


int main(){
	A *a = new B(1);
	a->f();
	cout<<sizeof A<<endl;
	cout<<sizeof B<<endl;
}