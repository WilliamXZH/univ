#include<iostream>
using namespace std;
//#define Max(a,b) (a>b?a:b)
//template<class T>
// template<typename T>T Max(T a,T b){return a>b?a:b;}
//int Max(int a,int b){return a>b?a:b;}
//char Max(char a,char b){return a>b?a:b;}
//double Max(double a,double b){return a>b?a:b;}
void main()
{
	int a=18,b=29;
	char c='a',d='A';
	double e=10.23,f=18.45;
	cout<<Max(a,b)<<endl;
	cout<<Max(c,d)<<endl;
	cout<<Max(e,f)<<endl;
}