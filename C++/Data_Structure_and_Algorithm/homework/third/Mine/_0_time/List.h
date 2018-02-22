class List
{
	public:
		int Insert(const int x,const int i);
		int Remove(int i);
	private:
		class ListNode
		{
			public:
				int data;
				ListNode *link;
		};
		ListNode *first,*last;
};
int List::Insert(const int x.const int i){
	ListNode *p=first;
	int k=0;
	while(p!=NULL&&K<I-1){
		p=p->link;
		k++;

	}
	if(i<0||p==NULL&&first!=NULL){
		cout<<"无效的插入位置!\n";
		return 0;
	}
	ListNode *newnode=new ListNode(x,NULL);
	if(first==NULL||i==0){
		newnode->first;
		if(first==NULL)last=newnode;
		first=newnode;
	}else{
		newnode->link=p->link;
		if(p->link==NULL)last=newnode;
		p->link=newnode;
	}
	return 1;
}
int List::Remove(int i){
	ListNode *p=first,*q;
	int k=0;
	while(p!=NULL&&k<i-1){
		p=p->link;
		k++;
	}
	if(i<0||p==NULL||p->link==NULL){
		cout<<"无效的删除位置!\n";
		return 0;
	}
	if(i==0){
		q=first;
		p=first=fitst->link;
	}else{
		q=p->link;
		p->link=q->link;
	}
	if(q==last)last=p;
	k=q->data;
	delete q;
	return k;
}