#include<iostream>
using namespace std;

struct test
{
	char c;
	short x;
	int y;
};

class tc
{

	char x[10];
	int y;
	double z;

	virtual void test(){};

	virtual void test2()=0;
//	virtual void test3();
//	virtual void test4();
//	virtual void test5();
};

int main(){
//	cout<<sizeof(char)<<endl;
//	cout<<sizeof(bool)<<endl;
//	cout<<sizeof(short)<<endl;
//	cout<<sizeof(int)<<endl;
//	cout<<sizeof(long)<<endl;
//	cout<<sizeof(float)<<endl;
//	cout<<sizeof(double)<<endl;
//
//	long i = ;
//	cout<<i<<endl;
	
	cout<<sizeof(test)<<endl;
	cout<<sizeof(tc)<<endl;
	//tc *t = new tc;

}