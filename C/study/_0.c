#include<stdio.h>
main()
{
	int a[10],i,j,k,x;
	printf("Input 10 numbers:\n");
	for(i=0;i<10;i++)scanf("%d",&a[i]);
	for(printf("\n"),i=0;i<10;i++)
	{
		for(k=i,j=i+1;j<10;j++)
		{
			if(a[j]<a[i])
			{
				k=j;
			}
		}
		if(i!=k)
		{
				x=a[i];
				a[i]=a[k];
				a[k]=x;
		}
	}
	printf("The sorted numbers:\n");
	for(i=0;i<10;i++)printf("%d ",a[i]);
}