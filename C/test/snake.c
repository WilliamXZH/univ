#include "stdafx.h"
#include <iostream>
#include <conio.h>
#include <time.h>
#include <windows.h>
using namespace std;
const int X=30,Y=15;                                              //初始边界大小
int level=1;                                                      //初始等级
int length=3;                                                     //初始长度
int food_bool=0;                                                  //食物是否存在
int food_x,food_y;                                                //食物存在的座标
char direction='d';                                               //初始方向
int success=1;                                                    //成功条件
void SetPoint(int x,int y)                                        //构造gotoxy函数
{
	COORD s={x,y};
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),s);
}
struct body{                                                      //构造蛇和墙体的身体
	int x,y;
	body *next;
};
body *head=new(struct body);                                      //声明蛇头
body *wall;                                                       //声明墙体的头节点

class snake{                                                      //构造蛇类

public:
	void gaming();                                                //声明游戏的主函数
	void map();                                                   //声明边界构造函数
    void paint_body();                                            //声明蛇体构造函数
	void food();                                                  //声明创建食物函数
	void str_wall();                                              //声明墙体构造函数
	void add_wall();                                              //声明墙体添加函数
};
void snake::str_wall()                                            //墙体构造函数
{
	struct body *p=new(struct body);         //声明并初始化操作节点
	wall=p;                                  //让墙体头节点等于p
	p->x=(rand()+time(NULL))%(X-3)+2;        //随机创建节点坐标
	p->y=(rand()+time(NULL))%(Y-3)+2;
	int k=0;
	while(k==0)                              //判断墙体是否出现在蛇身
    {
        k=1;
        struct body *q;
        q=head;
        while(q!=NULL)
        {
            if(p->x==q->x&&p->y==q->y)
            {
                k=0;
                p->x=(rand()+time(NULL))%(X-3)+2;
                p->y=(rand()+time(NULL))%(Y-3)+2;
                break;
            }
            q=q->next;
		}
    }
	SetPoint(p->x,p->y);
	cout<<"■";
	for(int i=0;i<10;i++)
	{
		p->next=new(struct body);                //构建10个初始墙体
		p=p->next;
		p->x=(rand()+time(NULL))%(X-3)+2;
		p->y=(rand()+time(NULL))%(Y-3)+2;
		while(k==0)                              //判断墙体是否出现在蛇身
    	{
	    	k=1;
			struct body *q;
    		q=head;
    		while(q!=NULL)
    		{
				if(p->x==q->x&&p->y==q->y)
				{
					k=0;
					p->x=(rand()+time(NULL))%(X-3)+2;
					p->y=(rand()+time(NULL))%(Y-3)+2;
					break;
				}
				q=q->next;
			}
		}
		k=0;
		SetPoint(p->x,p->y);                    //墙体出现位置正确时画出墙体
		cout<<"■";
	}
	p->next=NULL;                               //设置末节点为NULL
}
void snake::add_wall()                          //墙体添加函数
{
	struct body *p;
	for(int i=0;i<3;i++)                        //判断墙体是否成立
	{
		p=new(struct body);
		int k=0;
		p->x=(rand()+time(NULL))%(X-3)+2;
		p->y=(rand()+time(NULL))%(Y-3)+2;
		while(k==0)
    	{
	    	k=1;
			struct body *q;
    		q=head;
    		while(q!=NULL)
    		{
			if(p->x==q->x&&p->y==q->y)
			{
				k=0;
				p->x=(rand()+time(NULL))%(X-3)+2;
        		p->y=(rand()+time(NULL))%(Y-3)+2;
				break;
			}
			q=q->next;
		}
		}
		p->next=wall;
		wall=p;                                //将新得到的墙体插入到头节点
		SetPoint(p->x,p->y);
		cout<<"■";
	}
}
void snake::food()                  //创建食物函数
{
	int k;
	k=0;
	food_x=(rand()+time(NULL))%(X-3)+2;
	food_y=(rand()+time(NULL))%(Y-3)+2;
	body *p;
	while(k==0)
	{
		k=1;
		p=wall;
		while(p!=NULL)                  //判断食物是否出现在墙体上
		{
			if(p->x==food_x&&p->y==food_y)
			{
				k=0;
				food_x=(rand()+time(NULL))%(X-3)+2;
				food_y=(rand()+time(NULL))%(Y-3)+2;
				break;
			}
			p=p->next;
		}
		p=head;
		while(p!=NULL)                    //判断食物是否出现在蛇身上
		{
			if(p->x==food_x&&p->y==food_y)
			{
				k=0;
				food_x=(rand()+time(NULL))%(X-3)+2;
				food_y=(rand()+time(NULL))%(Y-3)+2;
				break;
			}
			p=p->next;
		}
	}
	SetPoint(food_x,food_y);              //画出食物
	cout<<"*";
	food_bool=1;
}
void snake::map()                         //边界构造函数
{
	system("cls");                          //清屏
	for(int i=0;i<=X;i+=2)                 //画出墙体
	{
		SetPoint(i,0);
		cout<<"■";
	}

	for(int i=1;i<Y;i++)
	{
		SetPoint(0,i);
		cout<<"■";
	}
	for(int i=1;i<Y;i++)
	{
		SetPoint(X,i);
		cout<<"■";
	}
	for(int i=0;i<=X+1;i+=2)
	{
		SetPoint(i,Y);
		cout<<"■";
	}
	SetPoint(X+5,3);                               //画出信息
	cout<<"长度："<<length;
	SetPoint(X+5,5);
	cout<<"等级："<<level;
}

void snake::paint_body()          //蛇体构造函数
{
	body *body;                   //构建身体，比较丑，但是不想改了
	head->x=X/2;                  //游戏开始时，蛇出现在地图中心，此时长度为三
    head->y=Y/2;
	body=new(struct body);
	head->next=body;
	body->x=head->x-1;
	body->y=head->y;
	body->next=new(struct body);
	body->next->x=head->x-2;
	body->next->y=head->y;
	body->next->next=NULL;
	SetPoint(head->x,head->y);
	cout<<"*";
	SetPoint(head->next->x,head->next->y);
	cout<<"*";
	SetPoint(head->next->next->x,head->next->next->y);
	cout<<"*";
}
void snake::gaming()            //这里是gaming!!!!!!!!!!
{
	int time_begin=clock();
	char x;
	char x1;
	struct body *newb;
	newb=new(body);
	map();                             //构造边界
	paint_body();                      //构造蛇身体
	str_wall();                        //构造墙体
	food();                            //构造一个食物
	x=direction;                   //读取方向
	while(1)
	{
		if(_kbhit())                   //如果读入缓存中有输入
		{
			x=_getch();
			while(_kbhit())            //读掉剩下的输入缓存中的数
				_getch();
		}
		        if(x==' ')
				{
						_getch();
						x=direction;
				}
				else
				if((x=='w'||x=='W')&&direction!='s')
				{
					newb->x=head->x;
					newb->y=head->y-1;
					x1='w';
				}
				else if((x=='a'||x=='A')&&direction!='d')
				{
					newb->x=head->x-1;
					newb->y=head->y;
					x1='a';
				}
				else if((x=='s'||x=='S')&&direction!='w')
				{
					newb->x=head->x;
					newb->y=head->y+1;
			    	x1='s';
				}
				else if((x=='d'||x=='D')&&direction!='a')
				{
					newb->x=head->x+1;
					newb->y=head->y;
				    x1='d';
				}
				else
				{
					if(x1=='w')
					{
						newb->x=head->x;
						newb->y=head->y-1;
					}
					else if(x1=='a')
					{
						newb->x=head->x-1;
						newb->y=head->y;
					}
					else if(x1=='s')
					{
						newb->x=head->x;
						newb->y=head->y+1;
					}
					else if(x1=='d')
					{
						newb->x=head->x+1;
						newb->y=head->y;
					}
				}
		if(clock()-time_begin>(500-level*45))//移动蛇身，随时间加快
		{
	    	time_begin=clock();
			{
				direction=x1;
				newb->next=head;
				head=newb;
			}
			if(head->x==food_x&&head->y==food_y)//遇见食物吃掉，食物小时
			{
				food_bool=0;
			}
			if(head->x==X||head->y==Y||head->x==0||head->y==0)//遇到墙体死亡
			{
				success=0;
			}
			else
			{
				body *p=head->next;
				if(food_bool==1)
				{
					while(p->next!=NULL)
					{
						if(p->x==head->x&&p->y==head->y)
							success=0;
						p=p->next;
					}
				}
				else
				{
					while(p!=NULL)
					{
						if(p->x==head->x&&p->y==head->y)
							success=0;
						p=p->next;
					}
				}
			}
			{
				body *p=wall;
				while(p!=NULL)
				{
					if(p->x==head->x&&p->y==head->y)//遇到墙体死亡
						success=0;
					p=p->next;
				}
			}
			if(success==0)
			{
				system("cls");
				cout<<"你失败了"<<endl;
				cout<<"死的时候你的长度为"<<length<<endl;
				break;
			}
			if(food_bool==1)
			{
				body *p=head;
				while(p->next->next!=NULL)//将指针移到末尾
				{
					p=p->next;
				}
				SetPoint(p->next->x,p->next->y);//蛇身移动后最后一部分消失
				cout<<" ";
				delete(p->next);
				p->next=NULL;
			}
			else
			{
				food();
				length++;
				if(length%5==0)
				{
					level++;
					add_wall();
				}
				if(level==10)
					success=2;
				SetPoint(X+5,3);
				cout<<"长度："<<length;
				SetPoint(X+5,5);
				cout<<"等级："<<level;
			}
			{
				SetPoint(head->x,head->y);//吃到食物后蛇身增加
				cout<<"*";
			}
			if(success==2)
			{
				system("cls");
				cout<<"你通关了"<<endl;
				break;
			}
			newb=new(body);
		}
		SetPoint(X+30,Y);
	}
}

void prompt()
{
	cout<<"****************************************************"<<endl;
	cout<<"*                欢迎进入贪吃蛇世界                *"<<endl;
	cout<<"*                 *代表蛇身或食物                  *"<<endl;
	cout<<"*                     ■代表墙                     *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*         初试身体长度为3，每到5的倍数升一级       *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*            wasd操控，注意切换输入法哦            *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*         每升一级速度加快，同时增加三个墙体       *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*                按任意键开始游戏                  *"<<endl;
	cout<<"*                ps:按空格键暂停                   *"<<endl;
	cout<<"****************************************************"<<endl;
	_getch();
}
int main(int argc,char argv[])
{
	snake H;
	prompt();
	system("cls");
	H.gaming();
	system("pause");
	return 0;
}

