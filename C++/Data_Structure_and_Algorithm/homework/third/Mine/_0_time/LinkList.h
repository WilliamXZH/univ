template <typename T>
class LinkNode
{
	public:
	T data;
	LinkNode<T> *link;
		LinkNode();
		LinkNode(const T &item);
		LinkNode(LinkNode<T> &p);
		void SetData(T value);//这四个函数是为了实现链节的封装，但为了后面代码的书写简便，并没有使用
		void SetLink(LinkNode<T> *p);
		T GetData();
		LinkNode<T> *GetLink();
};
template<typename T>
class LinkList
{
	public:
	LinkNode<T> *first,*last;
		LinkList();
		LinkList(T p[],int n);//通过数组来快速建立链表
		int GetLength();//获取链表长度
		int Insert(T value,int i=0);//在位置i插入数据value，若i默认为0，则在末尾添加链节
		int Insert(LinkNode<T> *p,int i=0);//功能同上
		void MakeEmpty();//置空链表
		T GetMin();//获取最小值
		T *Remove(int i);//移除第i个链节
		int RemoveValue(T value);//移除储存某个数据的链节，未实现
		int Remove(LinkNode<T> &item,int i);//移除第i个链节，但感觉基本没什么实际应用，此文件中没有实现此功能
		void Reverse_Recursive(LinkNode<T> *p);//逆置链表递归调用所用的具体函数
		void Reverse_Recursive_root();//逆置链表递归调用从这里开始，调用上一个函数
		void Reverse_Non_Recursive();//逆置链表非递归调用
		LinkNode<T> *Find(int i);//查找第i个链表
		LinkNode<T> *FindData(T value);//查找某个储存某个数据value的链表

		//int SetLast(LinkNode<T> *p){last=p;};//这两个函数也是为了实现封装，但也是为了代码书写简便并没有使用
		//LinkNode<T> *GetFirst(){return first;};

};
template<typename T>LinkNode<T>::LinkNode():link(NULL){}
template<typename T>LinkNode<T>::LinkNode(const T &item):data(item),link(NULL){}
template<typename T>LinkNode<T>::LinkNode(LinkNode<T> &p):data(item),link(NULL){}
template<typename T>void LinkNode<T>::SetData(T value):data(value){}
template<typename T>void LinkNode<T>::SetLink(LinkNode<T> *p):link(p){}
template<typename T>T LinkNode<T>::GetData(){return data;}
template<typename T>LinkNode<T> *GetLink(){return link;}

template<typename T>LinkList<T>::LinkList(){first=new LinkNode<T>();last=first;}
template<typename T>LinkList<T>::LinkList(T p[],int n){
	first=new LinkNode<T>();
	last=first;
	for(int i=0;i<n;i++)Insert(p[i],0);
}
template<typename T>void LinkList<T>::Reverse_Recursive_root(){
	LinkNode<T> *p=first->link;
	Reverse_Recursive(p);
	p->link=NULL;
}
template<typename T>void LinkList<T>::Reverse_Recursive(LinkNode<T> *p){
	if(p->link==NULL){first->link=p;return;}
	Reverse_Recursive(p->link);
	p->link->link=p;
}

template<typename T>void LinkList<T>::Reverse_Non_Recursive(){
	LinkNode<T> *p=first->link,*q,*r=NULL;
	while(p!=NULL){
		q=p->link;
		p->link=r;
		r=p;
		p=q;
	}
	first->link=r;
}
template<typename T>
T *LinkList<T>::Remove(int i){
	LinkNode<T> *p=Find(i-1),*q;
	if(p==NULL||p->link==NULL)return NULL;
	q=p->link;
	p->link=q->link;
	T value=q->data;
	if(q==last)last=p;
	delete q;
	return &value;
}
template<typename T>
void LinkList<T>::MakeEmpty(){
	LinkNode<T> *q;
	while(first->link!=NULL){
		q=first->link;
		first->link=q->link;
		delete q;
	}
	last=first;
}
template<typename T>
int LinkList<T>::GetLength(){
	LinkNode<T> *p=first->link;
	int count=0;
	while(p!=NULL){
		p=p->link;
		count++;
	}
	return count;
}
template<typename T>
LinkNode<T> *LinkList<T>::FindData(T value){
	LinkNode<T> *p=first->link;
	while(p!=NULL){
		if(p->data==value)return p;
		p=p->link;
	}
	return NULL;
}
template<typename T>
LinkNode<T> *LinkList<T>::Find(int i){
	LinkNode<T> *p=first;
	for(int j=0;j<i;j++){
		if(p->link==NULL)return NULL;
		else p=p->link;
	}
	return p;
}
template<typename T>
T LinkList<T>::GetMin(){
	T value;
	LinkNode<T> *p=first->link;
	value=p->data;
	while(p!=NULL){
		if(value>p->data)value=p->data;
		p=p->link;
	}
	return value;
}
template<typename T>
int LinkList<T>::Insert(T value,int i){
	LinkNode<T> *p=new LinkNode<T>(value);
	return Insert(p,i);
}
template<typename T>
int LinkList<T>::Insert(LinkNode<T> *p,int i){
	if(i<0||i>GetLength()+1)return 0;
	if(i==0){
		last->link=p;
		last=p;
		return 1;
	}
	LinkNode<T> *q=Find(i-1);
	if(q==NULL)return 0;
	p->link=q->link;
	q->link=p;
	return 1;
}