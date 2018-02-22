#ifndef NODE_H
#define NODE_H
#include <iostream>
using namespace std;
////////////////////////////////////////////////
class ArcNode;

class AdjList//存储边的信息
{
public:
	int position;
	string name;
	int weight;//存储边的长度（两景点之间的距离）
	int time;//存储边的时间（两景点之间的时间）
	AdjList *next;
		
	AdjList(int a,int b){position=a,weight=b;next=NULL;}
	AdjList(){next=NULL;}
	~AdjList(){};

private:

};


class ArcNode//存储顶点的信息
{
public:
	string name;
	AdjList *next;
	bool visited;
	bool biuld_rode;
	string intruduction;
	int popularity;
	string reating_area;
	string toillet;
	
	ArcNode(){next=NULL; visited=false;}
	~ ArcNode(){}
private:

};

/*
struct listnode
{
    int data;
    listnode * next;
};


class Slist
{
private:
    listnode *head;
public:
     Slist(){head=new listnode;head->next=NULL;}//构造函数
     ~Slist(){delete head;}//析构函数
     
	 void insert(int x);//在链表尾部依次加入值x
	 void insert(int i,int x);//在第i个位置插入元素x
	 int  getelem(int i);//获取第i个位置的元素值
	 bool IsOver(int i);//判断第i个元素是不是最后一个
	 int Last();//获取链表中的最后一个值
	 void print();

};


void Slist::insert(int x){
	
	listnode *p=head;
	while(p->next!=NULL){
		p=p->next;
	}
	listnode *s=new listnode;
	s->data=x;
    s->next=p->next;
    p->next=s;
}

void Slist::insert(int i,int x)
{
    listnode *p=head;int k=0;
    while(p&&k<i-1)
    {p=p->next;k++;}
    if(!p||k>i-1){cout<<"第"<<i-1<<"个元素不存在"<<endl;return ;}
    listnode  *s=new listnode;
    if(!s){cout<<"空间分配失败"<<endl;return ;}
    s->data=x;
    s->next=p->next;
    p->next=s;
}

int Slist::getelem(int i)
{
    listnode *p;
    int k,j;
    if(head->next==NULL){cout<<"表空"<<endl;return 0;}
    else
    {
        p=head;
		k=0;
        while(p&&k<i)
        {p=p->next;k++;}
        if(!p||k>i){cout<<"第"<<i<<"个元素不存在"<<endl;return 0;}
        return (p->data);
    }
}

bool Slist::IsOver(int x){

	listnode *p=head->next;
	while (p && x!=p->data)
	{
		p=p->next;
	}
	if (p->next==NULL) return true;
	else return false;
}

int Slist::Last(){
	listnode *p;
    p=head->next;
	while(p->next!=NULL) p=p->next;   
    return p->data;
}

void Slist::print()
{
    listnode *p;
    p=head->next;
    while(p!=NULL)
    {
        cout<<p->data<<" ";
        p=p->next;
    }
  cout<<endl;
}*/
////////////////////////////////////////////////
#endif