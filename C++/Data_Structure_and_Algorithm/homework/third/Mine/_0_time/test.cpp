#include<iostream>
#include"LinkList.h"
//void PrintAll(LinkList<int> list);
using namespace std;
void PrintAll(LinkList<int> &list){
	LinkNode<int> *p=list.first;
	while(p->link!=NULL){
		p=p->link;
		cout<<p->data<<" ";
	}
	cout<<endl;
}
int main()
{
	/*while(1){
		cout<<"********************"<<endl;
		cout<<"*1.��������        *"<<endl;
		cout<<"*2.ɾ������        *"<<endl;
		cout<<"*3.��������        *"<<endl;
		cout<<"*4.�ÿ�����        *"<<endl;
		cout<<"*5.��������        *"<<endl;
		cout<<"*6.��������        *"<<endl;
		cout<<"*7.�˳�ϵͳ        *"<<endl;
		cout<<"********************"<<endl;
	}*/
	int num[10]={11,22,33,44,55,66,77,88,99,101};
	LinkList<int> list=LinkList<int>(num,10);
	PrintAll(list);
	cout<<"��ȡ��Сֵ:"<<(list.GetMin())<<endl;
	cout<<"Ѱ�ҵ������:"<<list.Find(5)->data<<endl;
	//cout<<list.Find(11)->data<<endl;������
	cout<<"Ѱ������22:"<<list.FindData(22)->data<<endl;
	//cout<<list.FindData(23)->data<<endl;�����ڴ���
	cout<<"ɾ������������:"<<*(list.Remove(3))<<endl;
	cout<<"Ĭ�ϲ�������1(���뵽���):";
	list.Insert(1);
	PrintAll(list);
	cout<<"��������25����7��λ��:";
	list.Insert(25,7);
	//list.MakeEmpty();
	PrintAll(list);
	cout<<"�ǵݹ�����:";
	list.Reverse_Non_Recursive();
	PrintAll(list);
	cout<<endl<<"�ݹ�����:";
	list.Reverse_Recursive_root();
	PrintAll(list);

}