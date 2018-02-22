template<typename Type>class list;
template<typename Type>class ListNode
{
	friend class List<Type>;
	Type data;
	ListNode<Type> *link;
	public:
		ListNode();
		ListNode(const Type& item);
		ListNode<Type> *NextNode(){return link;}
		void InsertAfter(ListNode<Type> *p);
		ListNode<Type> *RemoveAfter();
};
template <typename Type>class List
{
	ListNode<Type> *first,*last;
	public:
		List(const Type& value){
			last=first=new ListNode<Type>(value);
		}
		~List();
		void MakeEmpty();
		int Length()const;
		int Insert(Type value,int i);
		ListNode<Type> *Find(Type value);
		ListNode<Type> *Find(int i);
		ListNode<Type> *GetNode(const Type& item,ListNode<Type> *next);
		Type *Remove(int i);
		Type *Get(int i);
};
template<typename Type>
ListNode<Type>::ListNode():link(NULL){}
template<typename Type>
ListNode<Type>::ListNode(const Type& item):data(item),link(NULL){}
template<typename Type>
void ListNode<Type>::InsertAfter(ListNode<Type> *p){
	p->link=link;
	link=p;
}
template<typename Type>
ListNode<Type>*ListNode<Type>::RemoveAfter(){
	ListNode<Type> *temppter=link;
	if(link==NULL)return NULL;
	link=temppter->link;
	return temppter;
}
template<typename Type>
ListNode<Type> *List<Type>::GetNode(const Type& item,ListNode<Type> *next=NULL){
	ListNode<Type> *newnode=new ListNode<Type>(item);
	newnode->link=next;
	return newnode;
}
template<typename Type>
List<Type>::~List(){
	MakeEmpty();
	delete first;
}
template<typename Type>
void List<Type>::MakeEmpty(){
	ListNode<Type> *q;
	while(first->link!=NULL){
		q=first->link;
		first->link=q->link;
		delete q;
	}
	last=first;
}
template<typename Type>
int List<Type>::Length()const{
	ListNode<Type> *p=first->link;
	int count=0;
	while(p!=NULL){
		P=P->link;
		count++;
	}
	return count;
}
template<typename Type>
ListNode<Type> *List<Type>::
Find(Type value){
	ListNode<Type> *p=first->link;
	while(p!=NULL&&p->data!=value)
		p=p->link;
	return p;
}
template<typename Type>
ListNode<Type> *List<Type>::Find(int i){
	if(i<-1)return NULL;
	else if(i==-1)return first;
	ListNode<Type> *p=first->link;
	int j=0;
	while(p!=NULL&&j<i){p=p->link;j++;}
	return p;
}
template<typename Type>
int List<Type>::Insert(Type value,int i){
	ListNode<Type> *p=Find(i-1);
	if(p==NULL)return 0;
	ListNode<Type>*newnode=GetNode(value,p->link);
	if(p->link==NULL)last=newnode;
	p->link=newnode;
	return 1;
}
template<typename Type>
Type *List<Type>::Remove(int i){
	ListNode<Type> *p=Find(i-1),*q;
	if(p==NULL||p->link==NULL)return NULL;
	q=p->link;
	p->link=q->link;
	Type value=new Type(q->data);
	if(q==last)last=p;
	delete q;
	return &value;
}
template<typename Type>
Type *List<Type>::Get(int i){
	ListNode<Type>*p=Find(i);
	if(p==NULL||p==first)return NULL;
	else return &p->data;
}