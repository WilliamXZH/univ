#include<stdio.h>
/*
main()
{
	char *p,s[]="ABCDEFG";
	for(p=s;*p!='\0';)
	{
		printf("%s\n",p);
		p++;
		if(*p!='\0')
			p++;
		else break;
	}
	{int a[10]={1,2,3,4,5,6,7,8,9,10},*q=&a[3],b;
	b=q[5];
	printf("%d",b);
}}
#include<string.h>
main()
{
	char s[81],*p1,*p2;
	int n;
	gets(s);
	n=strlen(s);
	p1=s;
	p2=&s[n-1];
	while(p2>=p1)
	{
		if(*p1!=*p2)break;
		else{p1++;p2--;}
	}
	if(p1<p2)printf("No\n");
	else printf("Yes\n");
}
char n=1;
main()
{
	int f(int x);
	int n,num;
	n=2;
	num=n*f(5)+3;
	printf("%d\n",num);
}
int f(int x){return n+x;}*/
main()
{
	int x=102,y=012;
	printf("%2d,%2d\n",x,y);
}