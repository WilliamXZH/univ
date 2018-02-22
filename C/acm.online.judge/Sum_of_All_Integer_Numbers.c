#include<stdio.h>
int main()
{
	int n,x,sum;
	while(scanf("%d",&n)!=EOF)
	{
		if(n>=1)for(x=1,sum=0;x<=n;sum+=x,x++);
		else for(x=n,sum=0;x<=1;sum+=x,x++);
		printf("%d\n",sum);
	}
	return 0;
}