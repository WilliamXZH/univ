#include<stdio.h>
char s[2000][2000];
int sa[2000][2000];
void run(int x,int y);
int num(int n,int m);
int min(int x,int y)
{
	return x<y?x:y;
}
int main()
{
	int n,m,t,i,j,k;
	scanf("%d %d %d",&n,&m,&t);
	memset (s,0,sizeof(s));
	memset(sa,0,sizeof(sa));
	for(i=0;i<n;i++)
	{
		scanf("%s",s[i]);
		for(j=0;j<m;j++)
		{
			if(s[i][j]=='#')sa[i][j]=1;
			else sa[i][j]=0;
		}
	}
	for(i=0;i<t;i++)
	{
		if(t>=((min(n,m)+1)/2))break;
		for(j=0;j<n;j++)
		{
			for(k=0;k<m;k++)
			{
				if(j==0||j==n-1||k==0||k==m-1||sa[j-1][k]==0||sa[j+1][k]==0||sa[j][k-1]==0||sa[j][k+1]==0||s[j][k]=='.')
					s[j][k]='.';
				else s[j][k]='#';
			}
		}
		for(j=0;j<n;j++)
		{
			for(k=0;k<m;k++)
			{
				if(s[j][k]=='#')sa[j][k]=1;
				else sa[j][k]=0;
			}
		}
	}
	printf("%d\n",num(n,m));
	for(i=0;i<n;printf("\n"),i++)for(j=0;j<m;printf("%c",s[i][j]),j++);
	return 0;
}
void run(int x,int y)
{
	sa[x][y]=1;
	if(s[x-1][y]=='#'&&sa[x-1][y]!=1)run(x-1,y);
	if(s[x+1][y]=='#'&&sa[x+1][y]!=1)run(x+1,y);
	if(s[x][y-1]=='#'&&sa[x][y-1]!=1)run(x,y-1);
	if(s[x][y+1]=='#'&&sa[x][y+1]!=1)run(x,y+1);
}

int num(int n,int m)
{
	int i,j,flag,x,y,k=0;
	memset(sa,0,sizeof(sa));
	for(i=0;i<n;i++)
	{
		for(j=0;j<m;j++)
		{
			if(sa[i][j]!=1&&s[i][j]=='#')
			{
				run(i,j);
				k++;
			}
		}
	}
	return k;
}