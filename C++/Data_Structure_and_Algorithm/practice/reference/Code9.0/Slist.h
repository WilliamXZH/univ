#ifndef SLIST_H
#define SLIST_H
#include<iostream>
#include<stdlib.h>
using namespace std;
////////////////////////////////////////
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
	 int  getloca(int x);//��ȡx��λ��
	 int  getNum();//��ȡ����ĳ���
	 int  have(int x);//�ж�x�������г��ּ���
	 // bool IsOver(int i);//�жϵ�i��Ԫ���ǲ������һ��
	 int Last();//��ȡ�����е����һ��ֵ
	 void print();
	 bool haveLoop();//�ж��Ƿ��л�·
	 bool firstEmerge(int i);//��һ��λ��i,�ж�i����Ӧ��λ���ǲ��ǵ�һ�γ���
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

bool Slist::firstEmerge(int i){
	
	int vall=getelem(i);
	for (int r = 1; r < i; r++)
	{
		int valll=getelem(r);
		if(valll==vall)return false;
	}
	return true;


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

int Slist::getNum(){
	int k=0;
	listnode *p;
    p=head->next;
    while(p!=NULL)
    {
        k++;
        p=p->next;
    }
	return k;

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

int Slist::have(int x){//�ж�x�������г��ּ���

	listnode *p=head->next;
	int time =0;
	while(p!=NULL)
    {
		if (p->data==x)
		{
			time++;
		}
        p=p->next;
    }
	return time;


}

int Slist::getloca(int x){//��ȡx��λ��
	
	listnode *p=head->next;
	int i=1;
	while (p->data!=x && p->next!=NULL){
		p=p->next;
		i++;
	}
	return i;	
}

int Slist::Last(){
	listnode *p;
    p=head->next;
	while(p->next!=NULL) p=p->next;   
    return p->data;
}

bool Slist::haveLoop(){
	//��ȡ����ĳ���
	int k=0;
	listnode *p;
    p=head->next;
    while(p!=NULL)
    {
        k++;
        p=p->next;
    }
	//cout<<"����ĳ���:"<<k<<endl;
	for (int i = 1; i < k+1; i++)
	{
		 int value = getelem(i);

		 int time = have(value);
		 //cout<<value<<"------"<<time<<"-----"<<endl;
		 if(time!=1) return true;

	}
	return false;
	//cout<<"^^^^^^^^^^^^^^^"<<endl;
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
}

////////////////////////////////////////
#endif