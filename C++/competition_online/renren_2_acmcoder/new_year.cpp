#include<iostream>
using namespace std;

int getMax(int n,int m);
int main()
{
	int n, m;
	//cin>>n>>m;
	//cout<<getMax(n,m);
	for(int i=1;i<=10;i++)
	{
		for(int j=1;j<=240;j++)
		{
			cout<<i<<' '<<j<<' '<<getMax(i,j)<<endl;
		}
		getchar();
	}
}

int getMax(int n, int m)
{
	int total = (240-m)/5;
	if(total<=0)
	{
		return 0;
	}
	for(int k=0;k<=n;k++)
	{
		if(total>=k)
		{
			total -= k;
		}else
		{
			return k-1;
		}
	}
	return n;
}