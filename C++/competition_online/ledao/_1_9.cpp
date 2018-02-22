#include<iostream>
using namespace std;

int increase(int a, int &b,int *c)
{
	a = a+1;
	b = b+1;
	*c = *c+1;
	return a+b+*c;
}

int main()
{
	int a = 1, b = 1;
	int *c = &a;
	int d = increase(a,b,c);
	printf("%d %d %d %d\n",a,b,*c,d);
	return 0;
}