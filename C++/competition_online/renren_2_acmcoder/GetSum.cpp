#include<iostream>
using namespace std;

void prints(int *p,int n)
{
	for(int i=0;i<n;i++)
	{
		cout<<p[i]<<' ';
	}
	cout<<endl;
}

void sort(int *p, int n);
int main()
{
	int n;
	int *l,*f;
	cin>>n;
	l = new int[n];
	f = new int[n];
	for(int i=0;i<n;i++)
	{
		cin>>l[i];
		f[i]=0;
	}
	prints(l,n);
	sort(l,n);
	prints(l,n);
	
	int count = 0;
	for(int j=0;i<n;j++)
	{
		if(f[j]!=0)
		{
			continue;
		}
	}
}

void sort(int *p, int n)
{
	for(int i=0;i<n;i++)
	{
		for(int j=i+1;j<n;j++)
		{
			if(p[j]>p[i])
			{
				int tmp = p[j];
				p[j] = p[i];
				p[i] = tmp;
			}
		}
	}
}