#include<iostream>
using namespace std;

int main()
{
	int x = 0;
	//(x++)++;
	++(++x);
	cout<<x<<endl;
	(++x)++;
	cout<<x<<endl;
}