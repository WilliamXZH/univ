#include<stdio.h>
#define num 1000000
long int tem[num];
int main()
{
	int i;
	long int a,m,n;
	while(scanf("%d",&a)!=EOF)
	//for(a=1;a<=3;a++)
	{
		if(a<=0)continue;
		memset (tem,0,sizeof(tem));
		for(n=1,m=1;n%a!=0;m++)
		{
			//tem[m-1]=n;
			tem[n]=1;
			n=(n*10+1)%a;
			if(tem[n]==1)break;
			//for(i=0;i<m;i++)if(n==tem[i])break;
			//if(i!=m)break;
			//if(m%10==0)getch();
			//printf("%d %d %d %d\n",n,a,m,tem[m-1]);
		}
		if(n%a==0)
		{
			printf("Singles' Day is on ");
			for(i=0;i<m;printf("1"),i++);
			printf(".\n");
		}
		else printf("There is no Singles' Day!\n");
	}
	return 0;
}