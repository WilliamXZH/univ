#include "stdafx.h"
#include <iostream>
#include <conio.h>
#include <time.h>
#include <windows.h>
using namespace std;
const int X=30,Y=15;                                              //��ʼ�߽��С
int level=1;                                                      //��ʼ�ȼ�
int length=3;                                                     //��ʼ����
int food_bool=0;                                                  //ʳ���Ƿ����
int food_x,food_y;                                                //ʳ����ڵ�����
char direction='d';                                               //��ʼ����
int success=1;                                                    //�ɹ�����
void SetPoint(int x,int y)                                        //����gotoxy����
{
	COORD s={x,y};
	SetConsoleCursorPosition(GetStdHandle(STD_OUTPUT_HANDLE),s);
}
struct body{                                                      //�����ߺ�ǽ�������
	int x,y;
	body *next;
};
body *head=new(struct body);                                      //������ͷ
body *wall;                                                       //����ǽ���ͷ�ڵ�

class snake{                                                      //��������

public:
	void gaming();                                                //������Ϸ��������
	void map();                                                   //�����߽繹�캯��
    void paint_body();                                            //�������幹�캯��
	void food();                                                  //��������ʳ�ﺯ��
	void str_wall();                                              //����ǽ�幹�캯��
	void add_wall();                                              //����ǽ����Ӻ���
};
void snake::str_wall()                                            //ǽ�幹�캯��
{
	struct body *p=new(struct body);         //��������ʼ�������ڵ�
	wall=p;                                  //��ǽ��ͷ�ڵ����p
	p->x=(rand()+time(NULL))%(X-3)+2;        //��������ڵ�����
	p->y=(rand()+time(NULL))%(Y-3)+2;
	int k=0;
	while(k==0)                              //�ж�ǽ���Ƿ����������
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
	cout<<"��";
	for(int i=0;i<10;i++)
	{
		p->next=new(struct body);                //����10����ʼǽ��
		p=p->next;
		p->x=(rand()+time(NULL))%(X-3)+2;
		p->y=(rand()+time(NULL))%(Y-3)+2;
		while(k==0)                              //�ж�ǽ���Ƿ����������
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
		SetPoint(p->x,p->y);                    //ǽ�����λ����ȷʱ����ǽ��
		cout<<"��";
	}
	p->next=NULL;                               //����ĩ�ڵ�ΪNULL
}
void snake::add_wall()                          //ǽ����Ӻ���
{
	struct body *p;
	for(int i=0;i<3;i++)                        //�ж�ǽ���Ƿ����
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
		wall=p;                                //���µõ���ǽ����뵽ͷ�ڵ�
		SetPoint(p->x,p->y);
		cout<<"��";
	}
}
void snake::food()                  //����ʳ�ﺯ��
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
		while(p!=NULL)                  //�ж�ʳ���Ƿ������ǽ����
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
		while(p!=NULL)                    //�ж�ʳ���Ƿ������������
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
	SetPoint(food_x,food_y);              //����ʳ��
	cout<<"*";
	food_bool=1;
}
void snake::map()                         //�߽繹�캯��
{
	system("cls");  
	int i;                        //����
	for(i=0;i<=X;i+=2)                 //����ǽ��
	{
		SetPoint(i,0);
		cout<<"��";
	}

	for(i=1;i<Y;i++)
	{
		SetPoint(0,i);
		cout<<"��";
	}
	for(i=1;i<Y;i++)
	{
		SetPoint(X,i);
		cout<<"��";
	}
	for(i=0;i<=X+1;i+=2)
	{
		SetPoint(i,Y);
		cout<<"��";
	}
	SetPoint(X+5,3);                               //������Ϣ
	cout<<"���ȣ�"<<length;
	SetPoint(X+5,5);
	cout<<"�ȼ���"<<level;
}

void snake::paint_body()          //���幹�캯��
{
	body *body;                   //�������壬�Ƚϳ󣬵��ǲ������
	head->x=X/2;                  //��Ϸ��ʼʱ���߳����ڵ�ͼ���ģ���ʱ����Ϊ��
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
void snake::gaming()            //������gaming!!!!!!!!!!
{
	int time_begin=clock();
	char x;
	char x1;
	struct body *newb;
	newb=new(body);
	map();                             //����߽�
	paint_body();                      //����������
	str_wall();                        //����ǽ��
	food();                            //����һ��ʳ��
	x=direction;                   //��ȡ����
	while(1)
	{
		if(_kbhit())                   //������뻺����������
		{
			x=_getch();
			while(_kbhit())            //����ʣ�µ����뻺���е���
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
		if(clock()-time_begin>(500-level*45))//�ƶ�������ʱ��ӿ�
		{
	    	time_begin=clock();
			{
				direction=x1;
				newb->next=head;
				head=newb;
			}
			if(head->x==food_x&&head->y==food_y)//����ʳ��Ե���ʳ��Сʱ
			{
				food_bool=0;
			}
			if(head->x==X||head->y==Y||head->x==0||head->y==0)//����ǽ������
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
					if(p->x==head->x&&p->y==head->y)//����ǽ������
						success=0;
					p=p->next;
				}
			}
			if(success==0)
			{
				system("cls");
				cout<<"��ʧ����"<<endl;
				cout<<"����ʱ����ĳ���Ϊ"<<length<<endl;
				break;
			}
			if(food_bool==1)
			{
				body *p=head;
				while(p->next->next!=NULL)//��ָ���Ƶ�ĩβ
				{
					p=p->next;
				}
				SetPoint(p->next->x,p->next->y);//�����ƶ������һ������ʧ
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
				cout<<"���ȣ�"<<length;
				SetPoint(X+5,5);
				cout<<"�ȼ���"<<level;
			}
			{
				SetPoint(head->x,head->y);//�Ե�ʳ�����������
				cout<<"*";
			}
			if(success==2)
			{
				system("cls");
				cout<<"��ͨ����"<<endl;
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
	cout<<"*                ��ӭ����̰��������                *"<<endl;
	cout<<"*                 *���������ʳ��                  *"<<endl;
	cout<<"*                     ������ǽ                     *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*         �������峤��Ϊ3��ÿ��5�ı�����һ��       *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*            wasd�ٿأ�ע���л����뷨Ŷ            *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*         ÿ��һ���ٶȼӿ죬ͬʱ��������ǽ��       *"<<endl;
	cout<<"*                                                  *"<<endl;
	cout<<"*                ���������ʼ��Ϸ                  *"<<endl;
	cout<<"*                ps:���ո����ͣ                   *"<<endl;
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

