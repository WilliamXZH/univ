#ifndef QUEUE_H
#define QUEUE_H
#include<iostream>
using namespace std;
//////////////////////////////////////
template<class T>
struct pnode
{
	T date;
	pnode* p;
	pnode(T e)
	{date=e;p=NULL;}
};

template<class T>
class myQueue
{
private:
	pnode<T>* head,*tail;
	int size;
public:	
	void push(T e)
	{
		if(size==0)
		{
			head=tail=new pnode<T>(e);
		}
		else
		{
			tail->p=new pnode<T>(e);
			tail=tail->p;
		}
		size++;
	}

	T front()
	{
		return head->date;
	}
	void pop()
	{
		pnode<T>* tempoint=head;
		head=head->p;
		delete tempoint;
		tempoint=NULL;
		size--;

	}
    bool empty()
	{
		if(size==0)
			return true;
		return false;
	}
	int getSize()
	{
		return size;
	}

	myQueue()
	{
		head=tail=NULL;
		size=0;
	}

};


//////////////////////////////////////
#endif