#ifndef NODE_H
#define NODE_H
#include <iostream>
using namespace std;
////////////////////////////////////////////////
class ArcNode;

class AdjList//�洢�ߵ���Ϣ
{
public:
	int position;
	string name;
	int weight;//�洢�ߵĳ��ȣ�������֮��ľ��룩
	int time;//�洢�ߵ�ʱ�䣨������֮���ʱ�䣩
	AdjList *next;
		
	AdjList(int a,int b){position=a,weight=b;next=NULL;}
	AdjList(){next=NULL;}
	~AdjList(){};

private:

};


class ArcNode//�洢�������Ϣ
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
     Slist(){head=new listnode;head->next=NULL;}//���캯��
     ~Slist(){delete head;}//��������
     
	 void insert(int x);//������β�����μ���ֵx
	 void insert(int i,int x);//�ڵ�i��λ�ò���Ԫ��x
	 int  getelem(int i);//��ȡ��i��λ�õ�Ԫ��ֵ
	 bool IsOver(int i);//�жϵ�i��Ԫ���ǲ������һ��
	 int Last();//��ȡ�����е����һ��ֵ
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
    if(!p||k>i-1){cout<<"��"<<i-1<<"��Ԫ�ز�����"<<endl;return ;}
    listnode  *s=new listnode;
    if(!s){cout<<"�ռ����ʧ��"<<endl;return ;}
    s->data=x;
    s->next=p->next;
    p->next=s;
}

int Slist::getelem(int i)
{
    listnode *p;
    int k,j;
    if(head->next==NULL){cout<<"���"<<endl;return 0;}
    else
    {
        p=head;
		k=0;
        while(p&&k<i)
        {p=p->next;k++;}
        if(!p||k>i){cout<<"��"<<i<<"��Ԫ�ز�����"<<endl;return 0;}
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