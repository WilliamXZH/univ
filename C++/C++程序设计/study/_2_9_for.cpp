#include<iostream>
using namespace std;
int main()
{
	int i,j,n=4;
	for(i=1;i<=n;i++)
	{
		for(j=1;j<=30;j++)
			cout<<' ';
		for(j=1;j<=8-2*i;j++)
			cout<<' ';
		for(j=1;j<=2*i-1;j++)
			cout<<'*';
		cout<<endl;
	}
	for(i=1;i<=n-1;i++)
	{
		for(j=1;j<=30;j++)
			cout<<' ';
		for(j=1;j<=7-2*i;j++)
			cout<<'*';
		cout<<endl;
	}
}