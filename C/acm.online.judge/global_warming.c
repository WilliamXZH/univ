#include<stdio.h>
char s[100][100][100];
int sa[100][100];
void run(int t,int x,int y);
void run(int t,int x,int y)
{
	sa[x][y]=1;
	if(s[t][x-1][y]=='#'&&sa[x-1][y]!=1)run(t,x-1,y);
	if(s[t][x+1][y]=='#'&&sa[x+1][y]!=1)run(t,x+1,y);
	if(s[t][x][y-1]=='#'&&sa[x][y-1]!=1)run(t,x,y-1);
	if(s[t][x][y+1]=='#'&&sa[x][y+1]!=1)run(t,x,y+1);
}
int num(int n,int m,int t)
{
	int i,j,flag,x,y,k=0;
	memset(sa,0,sizeof(sa));
	for(i=0;i<n;i++)
	{
		for(j=0;j<m;j++)
		{
			if(sa[i][j]!=1&&s[t][i][j]=='#'/*&&s[t][i-1][j]=='.'*/)
			{
				run(t,i,j);
				/*for(x=i,y=j,flag=0;sa[i][j]!=1;)
				{
					if(flag==0&&s[t][x][y+1]=='#'&&(s[t][x-1][y]=='.'||s[t][x-1][y+1]=='.'))
					{
						y++;
						sa[x][y]=1;
					}
					else if(flag==1&&s[t][x+1][y]=='#'&&(s[t][x+1][y+1]=='.'||s[t][x][y+1]=='.'))
					{
						x++;
						sa[x][y]=1;
					}
					else if(flag==2&&s[t][x][y-1]=='#'&&(s[t][x+1][y]=='.'||s[t][x+1][y-1]=='.'))
					{
						y--;
						sa[x][y]=1;
					}
					else if(flag==3&&s[t][x-1][y]=='#'&&(s[t][x-1][y-1]=='.'||s[t][x][y-1]=='.'))
					{
						x--;
						sa[x][y]=1;
					}
					else flag++;
					printf("%d (%d,%d) (%d,%d) %d\n",flag,i,j,x,y,sa[x][y]);
					if(flag>=4){flag=1;getch();};
					
				}*/
				k++;
			}
		}
	}
	return k;
}
int main()
{
	int n,m,t,i,j,k;
	scanf("%d %d %d",&n,&m,&t);
	memset (s,'.',sizeof(s));
	for(i=0;i<n;scanf("%s",s[0][i]),i++);
	for(i=0;i<t;i++)
	{
		for(j=0;j<n;j++)
		{
			for(k=0;k<m;k++)
			{
				if(j==0||j==n-1||k==0||k==m-1||s[i][j-1][k]=='.'||s[i][j+1][k]=='.'||s[i][j][k-1]=='.'||s[i][j][k+1]=='.')
					s[i+1][j][k]='.';
				else s[i+1][j][k]='#';
			}
		}
	}
	printf("%d\n",num(n,m,t));
	for(i=0;i<n;printf("\n"),i++)for(j=0;j<m;printf("%c",s[t][i][j]),j++);
	return 0;
}