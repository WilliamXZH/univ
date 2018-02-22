#include "iostream.h"
#include<stdlib.h>
template <class Type> class QueueItem;
template <class Type>
class Queue {
	public:
		friend ostream& operator<<(ostream &os,const Queue<Type> &q);
		Queue() : front( 0 ), back ( 0 ) { }
		~Queue(){}
		void add( const Type & );
		bool is_empty() const
		{
			return front == 0;
		}
		Type remove();
	private:
		QueueItem<Type> *front;
		QueueItem<Type> *back;
};
template <class Type>
class QueueItem
{
	public:
		QueueItem(Type val){item=val;next=0;}
		friend class Queue<Type>;
		friend ostream& operator<<(ostream &os,const Queue<Type> &q);
		friend ostream& operator<<(ostream &os,const QueueItem<Type> &qi);
	private:
		Type item;
		QueueItem *next;
};
template <class Type>
void Queue<Type>::add(const Type &val)
{
	QueueItem<Type> *pt =new QueueItem<Type>(val);
	if ( is_empty() )
		front = back = pt;
	else
	{
		back->next = pt;
		back = pt;
	}
}
template <class Type>
Type Queue<Type>::remove()
{
	if ( is_empty() )
	{
		cerr << "remove() on empty queue \n";
		exit(-1);
	}
	QueueItem<Type> *pt = front;
	front = front->next;
	Type retval = pt->item;
	delete pt;
	return retval;
}
template <class Type>
ostream& operator<<(ostream &os, const Queue<Type> &q) //������г�Ա
{
	os << "< ";
	QueueItem<Type> *p;
	for ( p = q.front; p; p = p->next )
	os << *p << "" ;//�õ���Queue��QueueItem��˽�г�Ա������轫���������
	//�غ�������ΪQueue��QueueItem����Ԫ,����û�н��˺�������ΪQueueItem
	os << " >";//����Ԫ��
	return os;
}
template <class Type>
ostream& operator<< ( ostream &os, const QueueItem<Type> &qi )
{
	os << qi.item;//�õ���QueueItem��˽�г�Ա������轫����������غ�������
	//ΪQueueItem����Ԫ
	return os;
}
void main()
{
	Queue<int> qi;
	cout << qi << endl;
	int ival;
	for ( ival = 0; ival < 10; ++ival )
	qi.add( ival );
	cout << qi << endl;
	int err_cnt = 0;
	for ( ival = 0; ival < 10; ++ival ) {
		int qval = qi.remove();
		if ( ival != qval ) err_cnt++;
	}
	cout << qi << endl;
	if ( !err_cnt )
	cout << "!! queue executed ok\n";
	else cout << "?? queue errors: " << err_cnt << endl;
}