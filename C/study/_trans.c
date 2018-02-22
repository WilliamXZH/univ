#include<stdio.h>
#include<math.h>
main()
{
	int i,x,y;
	printf("请输入一个二进制数:");
	scanf("%d",&x);
	for(y=0,i=0;x!=0;y+=x%10*(int)pow(2,i),x/=10,i++);
	printf("\n%d",y);
	printf("\n请输入一个二进制数:");
	scanf("%d",&x);
	for(y=0,i=0;x!=0;y+=(int)pow(2,i)*(x%(int)pow(10,i+1)/(int)pow(10,i)),x-=(x%(int)pow(10,i)),i++);
	printf("\n%d",y);
}