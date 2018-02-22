#include<iostream>
#include<cstdlib>
using namespace std;
class list
{
	public:
		typedef struct Node
		{
			int value;
			struct Node *Next;
			//struct Node *pre;
		}node;
		CreatList();
		//list(const int n);
		ArrayList(int array[],int n);
		//~list();
		void AddNode(int NewValue); 
		//void DelNode(int obst);
		//node GetNode(int se);//获取某个元素所在的节点
		void PrintAll();
		void reverse();//将链表中元素逆置
		void RemoveAll();
		int GetMin();//返回链表中最小的元素
	private:
		node *head;
		node *tail;
		int NumberOfLinkList;
		//node GetHead();
		//node GetTail();
		//SetTail(node *);//设置尾节点
};
list::CreatList(){
	node *NewNode=new node();
	head=NewNode;
	head->Next=NULL;
	tail=head;
	NumberOfLinkList=0;
	cout<<"The head of LinkList constructed."<<endl;
}
//list::list(const int n){
//	CreatList();
//	for(int i=0;i<n;i++)
//	{
//		AddNode(i);
//	}
//	cout<<"The maintain of LinkList is"<<n<<endl;
//}
list::ArrayList(int array[],int n){
	int i;
	CreatList();
	for(i=0;i<n;i++){
		cout<<"prepare to add "<<array[i]<<endl;
		AddNode(array[i]);
		cout<<"added "<<array[i]<<" finshed"<<endl;
	}

}
//template<typename T>node *list<T>::GetHead(){return this.head;}
//template<typename T>node *list<T>::GetTail(){return this.tail;}
//template<typename T>void list<T>::SetTail(node *now){tail=now;}
void list::AddNode(int NewValue){
	node *NewNode=new node();
	NewNode->value=NewValue;
	NewNode->Next=NULL;
	tail->Next=NewNode;
	tail=NewNode;
	NumberOfLinkList++;
}
void list::PrintAll(){
	node *now=head;
	while(now->Next!=NULL){
		now=now->Next;
		cout<<(now->value)<<" ";
	}
	cout<<endl;
}
int list::GetMin(){
	int small;
	node *now=head;
	if(head->Next!=NULL)head->Next;
	else return 0;
	small=now->value;
	while(now->Next!=NULL){
		now=now->Next;
		if(small>=now->value)small=now->value;
	}
	return small;

}
void list::reverse(){
	int *linklist=(int *)malloc(NumberOfLinkList*sizeof(int));//new int(NumberOfLinkList);
	//int linklist[10];
	cout<<"NumberOfLinkList:"<<NumberOfLinkList<<endl;
	int i=0;
	node *now=head;
	while(now->Next!=NULL){
		now=now->Next;
		linklist[i]=now->value;
		i++;
	}
	//for(int j=0;j<i;j++)cout<<linklist[j]<<" ";
	//RemoveAll();
	//ArrayList(linklist,i);
	now=head;
	for(;now->Next!=NULL&&i>=0;){
		now=now->Next;
		now->value=linklist[--i];
	}
}
void list::RemoveAll(){
	node *now=head->Next;
	tail=head;
	int i=0;
	cout<<"???"<<endl;
	while(now->Next!=NULL){
		tail->Next=NULL;
		tail=now;
		now=now->Next;
		cout<<"delete "<<i++<<endl;
	}
}