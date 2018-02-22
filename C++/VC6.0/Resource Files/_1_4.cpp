#include<iostream>
using namespace std;
class A{public:A(){cout<<"A's con."<<endl;}};
class B{public:B(){cout<<"B's con."<<endl;}};
class C:public A,public B
{
	private:
		A ma;
		B mb;
	public:
		C():B(),A(),mb(),ma(){cout<<"C's con."<<endl;}
};
void main(){C obj[2];}