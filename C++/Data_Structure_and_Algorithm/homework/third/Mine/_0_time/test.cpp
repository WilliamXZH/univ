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
		cout<<"*1.插入链节        *"<<endl;
		cout<<"*2.删除链节        *"<<endl;
		cout<<"*3.查找链节        *"<<endl;
		cout<<"*4.置空链表        *"<<endl;
		cout<<"*5.逆置链表        *"<<endl;
		cout<<"*6.排序链表        *"<<endl;
		cout<<"*7.退出系统        *"<<endl;
		cout<<"********************"<<endl;
	}*/
	int num[10]={11,22,33,44,55,66,77,88,99,101};
	LinkList<int> list=LinkList<int>(num,10);
	PrintAll(list);
	cout<<"获取最小值:"<<(list.GetMin())<<endl;
	cout<<"寻找第五个数:"<<list.Find(5)->data<<endl;
	//cout<<list.Find(11)->data<<endl;不存在
	cout<<"寻找数字22:"<<list.FindData(22)->data<<endl;
	//cout<<list.FindData(23)->data<<endl;不存在此数
	cout<<"删除第三个数字:"<<*(list.Remove(3))<<endl;
	cout<<"默认插入数字1(插入到最后):";
	list.Insert(1);
	PrintAll(list);
	cout<<"插入数字25到第7个位置:";
	list.Insert(25,7);
	//list.MakeEmpty();
	PrintAll(list);
	cout<<"非递归逆置:";
	list.Reverse_Non_Recursive();
	PrintAll(list);
	cout<<endl<<"递归逆置:";
	list.Reverse_Recursive_root();
	PrintAll(list);

}