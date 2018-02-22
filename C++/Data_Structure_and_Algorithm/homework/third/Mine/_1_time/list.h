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
		node GetNode(T se);//��ȡĳ��Ԫ�����ڵĽڵ�
		void PrintAll();
		void reverse();//��������Ԫ������
		T SeqList();//������������С��Ԫ��
	private:
		node *head;
		node *tail;
		//node GetHead();
		//node GetTail();
		//SetTail(node *);//����β�ڵ�
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


