#include<iostream>
using namespace std;


class test
{
};


int main(){

	test *a1;
	test *b1;
	test *a2;
	test *b2;
	const test *c;
	const test *d;
	//static test *e;
	//static test *f;
	cout<<(a1==b1)<<endl;
	cout<<(a2==b2)<<endl;
	cout<<(c==d)<<endl;
	//cout<<(e==f)<<endl;
	cout<<a1<<endl;
	cout<<b1<<endl;
	cout<<a2<<endl;
	cout<<b2<<endl;
	cout<<c<<endl;
	cout<<d<<endl;
	//cout<<e<<endl;
	//cout<<f<<endl;

//	int a1 = 13;
//	int b1 = 13;
//	static int a2 = 1;
//	static int b2 = 1;
//	const int a3 = 2;
//	const int b3 = 2;
//	static const int a4 = 3;
//	static const int b4 = 3;
//	cout<<(a1==b1)<<endl;
//	cout<<(a2==b2)<<endl;
//	cout<<(a3==b3)<<endl;
//	cout<<(a4==b4)<<endl;
}