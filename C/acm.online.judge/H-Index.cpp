//#include<stdio.h>
#include<iostream>
#include <algorithm>  
#define T 10
#define N 10000
using namespace std;
int arr[N],h[T],n[T];
bool cmp (int a,int b) {  
    return a > b;  
}  
int main()
{
	int t,i,j,tem;
	cin>>t;
	for(i=0;i<t;i++)
	{
		cin>>n[i];
		for(j=0;j<n[i];j++)cin>>arr[j];
		/*for(x=0;x<n[i];x++)
		{
			for(y=x+1;y<n[i];y++)
			{
				if(arr[y]>arr[x])
				{
					tem=arr[y];
					arr[y]=arr[x];
					arr[x]=tem;
				}
			}
		}*/
        sort (arr+1, arr+n[i],cmp);
		for(j=0;j<n[i];j++)if(j+1>arr[j]){h[i]=j;break;}
	}
	for(i=1,tem=h[0];i<t;i++)
	{
		if(tem<h[i])tem=h[i];
	}
	cout<<tem<<endl;
	return 0;
}