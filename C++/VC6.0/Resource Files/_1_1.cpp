#include<iostream>
using namespace std;
class Base
{
	public:
		Base(){a=0;cout<<"Default Contruct base.\n";}
		Base(int d){a=d;cout<<"Contruct base.\n";}
		~Base(){cout<<"Decontruct base"<<a<<endl;}
		void print(){cout<<a;}
		int GetA(){return a;}
	private:
		int a;
};
class Derived:public Base
{
	private:
		int b;
		Base m;
	public:
		Derived(){b=0;cout<<"Default construct Derived.\n";}
		Derived(int i,int j,int k);
		~Derived(){cout<<"Deconstruct Derived"<<b<<endl;}
		void print(){Base::print();cout<<","<<b<<","<<m.GetA()<<endl;}
};
Derived::Derived(int i,int j,int k):Base(i),m(j),b(k)
{
	cout<<"Construct Derived.\n";
}
void main()
{
	Derived d[2];
	d[0]=Derived(3,4,5);
	d[1]=Derived(7,8,9);
	for(int i=0;i<2;i++)
		d[i].print();
}