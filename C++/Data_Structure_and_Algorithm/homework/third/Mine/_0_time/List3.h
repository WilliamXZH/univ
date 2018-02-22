enum Boolean{False,True};
template<typename Type>class List;
template<typename Type>class ListIterator;
template<typename Type>class ListNode{
	friend class List<Type>;
	friend class ListIterator<Type>;
	public:
	private:
		Type data;
		ListNode<Type> *link;
};
template<typename Type>class List
{
	public:
	private:
		ListNode<Type>*first,*last;
};
template<typename Type>class ListIterator
{
	public:
		ListIterator(const List<Type>& l):list(l),current(l.first->link){}
	private:
		list<Type> list;
	ListNode<Type>* current;

};
template<typename Type>Boolean listIterator<Type>::NotNull(){
	if(current!=NULL)return True;
	else return False;
}
template<typename Type>Boolean ListIterator<Type>::NextNotNull(){
	if(current!=NULL&&current->link!=NULL)return True;
	else return False;
}
template<typename Type>
ListNode<Type>*ListIterator<Type>::Firster(){
	current=list.first;
	return current;
}
template<typename>
Type *ListIterator<Type>::First(){
	if(list.first->link!=NULL){
		current=list.first->link;
		return &current->data;
	}
	else{
		current=NULL;
		return NULL;
	}
}
template<typename Type>
Type* ListIterator<Type>::Next(){
	if(current!=NULL&&current->link!=NULL){
		current=current->link;
		return &current->data;
	}
	else{current=NULL;return NULL;}
}
int sum(const List<int>&l){
	ListIterator<int> li(l);
	int *p=li.First();
	retval=0;
	while(p!=null){
		retval+=*p;
		p=li.Next();
	}
	return retval;
}