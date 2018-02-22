#include<iostream>
using namespace std;

int main()
{
	int *a, *b;
	int m, n;
	cin>>m;
	a = new int[m];
	for ( int i=0; i<m; i++)
	{
		cin>>a[i];
	}
	cin>>n;
	b = new int[n];
	for ( int j=0; j<n; j++)
	{
		cin>>b[j];
	}
	bool flag = true;
	for (int x=0; x<n; x++)
	{
		for (int y=0; y<m; y++)
		{

			if (b[x]==a[y])
			{			
				if (!flag)
				{
					cout<<' ';
				}else
				{
					flag = false;
				}
				cout<<b[x];
			}
		}
	}
}