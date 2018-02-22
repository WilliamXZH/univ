#include<iostream>
using namespace std;

class A
{
	int i;
};

class B
{
	A *p;
	public:
		B(){p=new A;}
		~B(){delete p;}
};
void sayHello(B &b)
{
	cout<<"helloWorld"<<endl;
}

int main()
{
	B b;
	sayHello(b);
}