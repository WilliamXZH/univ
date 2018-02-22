template<typename T>
class list
{
	public:
		typedef struct Node
		{
			T value;
			struct Node *Next;
			//struct Node *pre;
		}node;
		list();
		list(const int n);
		//list(char c);
		//list(int n[]);
		//list(string str[]);
		//~list();
		void AddNode(T newt); 
		void DelNode(T obst);
		node GetNode(T se);//获取某个元素所在的节点
		void PrintAll();
		void reverse();//将链表中元素逆置
		T SeqList();//返回链表中最小的元素
	private:
		node *head;
		node *tail;
		//node GetHead();
		//node GetTail();
		//SetTail(node *);//设置尾节点
};
template<typename T>list<T>::list(){
	head->Next=NULL;
	tail=head;
	cout<<"The head of LinkList contructed."<<endl;
}
template<typename T>list<T>::list(const int n){
	list();
	for(int i=0;i<n;i++)
	{
		AddNode(i);
	}
	cout<<"The container of LinkList is"<<n<<endl;
}
//template<typename T>node *list<T>::GetHead(){return this.head;}
//template<typename T>node *list<T>::GetTail(){return this.tail;}
//template<typename T>void list<T>::SetTail(node *now){tail=now;}
template<typename T>void list<T>::AddNode(T NewValue){
	node NewNode;
	NewNode.value=NewValue;
	tail->Next=&NewNode;
	tail=&NewNode;
}
template<typename T>void list<T>::PrintAll(){
	node *now=head;while(now->Next!=NULL){
		now=now->Next;
		cout<<(now->value)<<endl;
	}
}


