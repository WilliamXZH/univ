#include<iostream>
using namespace std;

int max1(int x,int y)
{
	if(x>=y)return x;
	else return y;
}
int max1(int x,int y,int z)
{
	return x>y?(x>z?x:z):(y>z?y:z);
}
double max1(double x,double y)
{
	if(x>=y)return x;
	else return y;
}
double max1(double x,double y,double z)
{
	return x>y?(x>z?x:z):(y>z?y:z);
}

void main()
{
	int a=1,b=2,c=3;
	double d=1.2,e=1.5,f=2.1;
	cout<<"between integer "<<a<<" and "<<b<<", the max is "<<max1(a,b)<<endl;
	cout<<"between integer "<<a<<", "<<b<<" and "<<c<<", the max is "<<max1(a,b,c)<<endl;
	cout<<"between double "<<d<<" and "<<e<<", the  max is "<<max1(d,e)<<endl;
	cout<<"between double "<<d<<", "<<e<<" and "<<f<<", the max is "<<max1(d,e,f)<<endl;
}