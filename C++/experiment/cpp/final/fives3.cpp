#include <windows.h>
#include <iostream>
#include<ctime>
#include<cstdlib>
#include<conio.h>
#define up 'w'
#define left 'a'
#define down 's'
#define right 'd'
#define lz 'p'
#define cls 'q'
using namespace std;
class fives
{
	public:
	int player,x,y;
	int Q[20][20];
	fives();
	void gotoxy(int x, int y);
	void drawqipan();
	 
	void jilu()
	{
		Q[x][y]=player%2+1;
		player++;
	}
	 
	void cluozi();
	void luozi()
	{
		if(Q[x][y]==0)
		{
			if(player%2)
			{
				jilu();
				cout<<"●"; 
			}
			else
			{
				jilu();
				cout<<"○";
			}
			gotoxy(x,y);
		}
	}
	int checkWin()
	{
		int p,r,c,i,j,count;
		for(c=0;c<30;c++)
		{
			for(r=0;r<20;r++)
			{
				if(Q[r][c]!=0)p=Q[r][c];
				else continue;
				i=r;j=c;  
				count=1;
				while(--j>=0 &&Q[i][j]==p)count++;  j=c;
				while(++j<20 &&Q[i][j]==p)count++;  j=c;
				if(count>=5)
					return p;
							//检查行
				count=1;
				while(--i>=0 &&Q[i][j]==p)count++;  i=r;
				while(++i<20 &&Q[i][j]==p)count++;  i=r;
				if(count>=5)
					return p;
							//检查反斜边
				count=1;
				while((--j>=0&&--i>=0) &&Q[i][j]==p)count++;  i=r;j=c;
				while((++j<20&&++i<20) &&Q[i][j]==p)count++;  i=r;j=c;
				if(count>=5)
					return p;
							//检查正斜边
				count=1;
				while(--j<20&&--i>=0 &&Q[i][j]==p)count++;  i=r;j=c;
				while(--j>=0&&++i<20 &&Q[i][j]==p)count++;  i=r;j=c;
				if(count>=5)
					return p;
			}
		}
		return 0;
	}
	void Keypress(char n) //光标位置移动
	{
		switch(n)
		{
		case up:if(y<=0)y=19;else y--;gotoxy(x,y);break;
			//向上移动光标
		case left:if(x<=0)x=19;else x--;gotoxy(x,y);break;
			//向左移动光标
		case right:if(x>=19)x=0;else x++;gotoxy(x,y);break;
			//向右移动光标
		case down:if(y>=19)y=0;else y++;gotoxy(x,y);break;
			//向下移动光标
		case lz:luozi();break;
			//开始落子操作
		case cls:drawqipan();break;
			//重新开始
		}
	}
};
fives::fives(){player=0;}
void fives::cluozi()
{
	srand((unsigned)time(NULL));
	do{x=rand()%20;y=rand()%20;}while(Q[x][y]!=0);
	if(Q[x][y]==0) 
	{
		jilu();
		gotoxy(x,y);
		cout<<"○";
	}
}
void fives::gotoxy(int x, int y){COORD c;c.X=2*x;c.Y=y; SetConsoleCursorPosition (GetStdHandle(STD_OUTPUT_HANDLE), c);}
void fives::drawqipan()
	{
		int i,j;
		system("cls");
		for(i=0;i<20;i++)
		{
			for(j=0;j<20;j++)
			{
				Q[i][j]=0;
				cout<<"十";
			}
			cout<<"\n";
		}
		x=0;y=0;
		gotoxy(0,0);
	}
main()
{
    system("color 2f");
	while(1){
		char press;
		int winer=0,i,flag=0;
		fives nf;
		nf.drawqipan();
		while(1)
		{
			if(++i%2==1)do{press=getch();nf.Keypress(press);}while(press!='p'||nf.Q[nf.x][nf.y]!=0);
			else nf.cluozi();
			winer=nf.checkWin();
			if(winer!=0)nf.gotoxy(0,20);
			if(winer==2)cout<<"the side of ● wins\n";
			else if(winer==1)cout<<"the side of ○ wins\n";
			else continue;
			cout<<"do you want to play again?(y/n):";
			while(1){
				press=getch();
				if(press=='n'||press=='N')
					break;
				else if(press=='y'||press=='Y')
				{
					flag=1;
					break;
				}
				else continue;
			}
			if(flag==0||flag==1)break;
		}
		if(flag==0)break;
	}
}