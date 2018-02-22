template <typename T>
class LinkNode
{
	public:
	T data;
	LinkNode<T> *link;
		LinkNode();
		LinkNode(const T &item);
		LinkNode(LinkNode<T> &p);
		void SetData(T value);//���ĸ�������Ϊ��ʵ�����ڵķ�װ����Ϊ�˺���������д��㣬��û��ʹ��
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
		LinkList(T p[],int n);//ͨ�����������ٽ�������
		int GetLength();//��ȡ������
		int Insert(T value,int i=0);//��λ��i��������value����iĬ��Ϊ0������ĩβ�������
		int Insert(LinkNode<T> *p,int i=0);//����ͬ��
		void MakeEmpty();//�ÿ�����
		T GetMin();//��ȡ��Сֵ
		T *Remove(int i);//�Ƴ���i������
		int RemoveValue(T value);//�Ƴ�����ĳ�����ݵ����ڣ�δʵ��
		int Remove(LinkNode<T> &item,int i);//�Ƴ���i�����ڣ����о�����ûʲôʵ��Ӧ�ã����ļ���û��ʵ�ִ˹���
		void Reverse_Recursive(LinkNode<T> *p);//��������ݹ�������õľ��庯��
		void Reverse_Recursive_root();//��������ݹ���ô����￪ʼ��������һ������
		void Reverse_Non_Recursive();//��������ǵݹ����
		LinkNode<T> *Find(int i);//���ҵ�i������
		LinkNode<T> *FindData(T value);//����ĳ������ĳ������value������

		//int SetLast(LinkNode<T> *p){last=p;};//����������Ҳ��Ϊ��ʵ�ַ�װ����Ҳ��Ϊ�˴�����д��㲢û��ʹ��
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