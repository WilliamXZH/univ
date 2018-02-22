#include<iostream>
using namespace std;

int main()
{
	int n, k, count=0;
	cin>>n>>k;

	int less = k;
	int more = k-k-1;

	int *p = new int[n];
	int cur = 0;
	int *flag = new int[n];
	for(int i=0;i<n;i++)
	{
		flag[i] = 1;
	}
	while (true)
	{

		bool isBreak = true;
		for (int i=0;i<n ;i++ )
		{
			if(flag[n]!=n)
			{
				isBreak = false;
				break;
			}
		}
		if(isBreak)
		{
			break;
		}
	}
}

int getCount(int *p,int cur, int n, int less, int more)
{
	int count = 1;
	if(less==0&&more==0)
	{
		return count;
	}
	for(int i=0;i<n;i++)
	{
		bool is = true;
		for(int j=0;j<cur;j++)
		{
			if(i==p[j])
			{
				is = false;
				break;
			}
		}
		if(is)
		{
			if(i>p[cur])
			{

			}
		}
	}
}