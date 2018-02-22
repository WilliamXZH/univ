#include<iostream>
using namespace std;

short int factorial(short int n)
{
	if (n<0)
	{
		return -1;
	}else if (n==0||n==1)
	{
		return 1;
	}else
	{
		return n*factorial(n-1);
	}
}

int main()
{
	printf("%d\n",factorial(9));
	return 0;
}