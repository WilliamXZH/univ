#include"IntList.h"
//#include"list.h"
int main()
{
	//list<int> *LinkList=new list<int>(5);
	int a[10]={0,1,2,-3,4,-1,6,-7,8,9};
	list LinkList2;
	//cout<<"???"<<endl;
	LinkList2.ArrayList(a,10);
	//LinkList->PrintAll();
	LinkList2.PrintAll();
	cout<<LinkList2.GetMin()<<endl;
	LinkList2.reverse();
	LinkList2.PrintAll();
	cout<<"test finished"<<endl;
}