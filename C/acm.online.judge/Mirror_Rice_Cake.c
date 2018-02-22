#include<stdio.h>
#define N 1000
int A[N];
int main()
{
	int n,i,j,tem;
	while(scanf("%d",&n)!=EOF)
	{
		for(i=0;i<n;i++)scanf("%d",&A[i]);
		for(i=0;i<n;i++)
		{
			for(j=i+1;j<n;j++)
			{
				if(A[j]<A[i])
				{
					tem=A[j];
					A[j]=A[i];
					A[i]=tem;
				}
			}
			//printf("%d ",A[i]);
		}
		//printf("\n");
		for(i=0,j=1,tem=A[0];tem<A[n-1];i++)
		{
			if(tem<A[i+1])
			{
				tem+=A[i+1];
				j++;
			}
		}
		printf("%d\n",j);
	}
}