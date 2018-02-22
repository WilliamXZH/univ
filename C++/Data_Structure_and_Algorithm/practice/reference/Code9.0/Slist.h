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
     Slist(){head=new listnode;head->next=NULL;}//构造函数
     ~Slist(){delete head;}//析构函数
     
	 void insert(int x);//在链表尾部依次加入值x
	 void insert(int i,int x);//在第i个位置插入元素x
	 int  getelem(int i);//获取第i个位置的元素值
	 int  getloca(int x);//获取x的位置
	 int  getNum();//获取链表的长度
	 int  have(int x);//判断x在链表中出现几次
	 // bool IsOver(int i);//判断第i个元素是不是最后一个
	 int Last();//获取链表中的最后一个值
	 void print();
	 bool haveLoop();//判断是否有回路
	 bool firstEmerge(int i);//给一个位置i,判断i所对应的位置是不是第一次出现
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
    if(!p||k>i-1){cout<<"第"<<i-1<<"个元素不存在"<<endl;return ;}
    listnode  *s=new listnode;
    if(!s){cout<<"空间分配失败"<<endl;return ;}
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

int Slist::have(int x){//判断x在链表中出现几次

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

int Slist::getloca(int x){//获取x的位置
	
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
	//获取链表的长度
	int k=0;
	listnode *p;
    p=head->next;
    while(p!=NULL)
    {
        k++;
        p=p->next;
    }
	//cout<<"链表的长度:"<<k<<endl;
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