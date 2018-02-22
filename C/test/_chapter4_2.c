#include<stdio.h>
#include<string.h>
#define n 30
void main()
{
	int i,j;
	char ch[n],c;
	for(i=0;i<n;i++)
	{
		ch[i]=getch();
		if(isupper(ch[i]))ch[i]=ch[i]+32;
		printf("%c %d\t",ch[i],ch[i]-'a'+1);
	}
	printf("ÅÅÐò:\n");
	for(i=0;i<n;i++)
	{
		for(j=i+1;j<n;j++)
		{
			if(ch[i]>ch[j])
			{
				c=ch[i];
				ch[i]=ch[j];
				ch[j]=c;
			}
		}
		for(j=0;j<i;j++)
			if(ch[i]==ch[j])break;
		if(j==i)printf("%c ",ch[i]);
	}
	printf("\n");
}