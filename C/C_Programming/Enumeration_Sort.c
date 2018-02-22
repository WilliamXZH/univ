#include<stdio.h>
#define N 10
void main()
{
	int a[N],i,j,t;
	printf("input %d numbers:\n",N);
	for(i=0;i<N;i++)scanf("%d",&a[i]);
	for(i=0;i<N-1;i++)
	{
		for(j=i+1;j<N;j++)
		{
			if(a[i]>a[j])
			{
				t=a[i];
				a[i]=a[j];
				a[j]=t;
			}
		}
	}
	printf("the sorted number:\n");
	for(i=0;i<N;i++)printf("%4d",a[i]);
	printf("\n");
}