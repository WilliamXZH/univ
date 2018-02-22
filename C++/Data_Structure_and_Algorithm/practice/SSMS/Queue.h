#ifndef QUEUE_H
#define QUEUE_H


template<class T> 
class QueueNode{
public:
	T data;
	QueueNode* next;
};

template<class T> 
class queue{
	private:
		int count;
		QueueNode<T> *head,*tail;
		//QueueNode *head,*tail;

		void init();
	public:
		queue();
		~queue();

		void empty();
		void push(T ele);
		//void push(zanlind ele);
		void pop();
		bool isEmpty();
		int size();
		T getHead();
		//zanlind getHead();
};


template<class T>
queue<T>::queue(){
	//queue::queue(){
	init();
}
template<class T>
queue<T>::~queue(){
	
}

template<class T>
void queue<T>::init(){
	//void queue::init(){
	
	count=0;
	
	head=NULL;
	tail=NULL;
}

template<class T>
void queue<T>::empty(){
	//void queue::empty(){
	while(tail!=NULL){
		pop();
	}
}
template<class T>
int queue<T>::size(){
	//int queue::size(){
	return count;
}


template<class T>
void queue<T>::push(T ele){
	//void queue::push(zanlind ele){
	QueueNode<T> *newNode=new QueueNode<T>();
	
	newNode->data=ele;
	newNode->next=NULL;
	
	if(head==NULL){
		head=newNode;
	}else{
		tail->next=newNode;
	}
	tail=newNode;
	
	count++;
	
}

template<class T>
void queue<T>::pop(){
	//bool queue::pop(){
	QueueNode<T> *temp;
	
	if(head!=NULL){	
		temp=head;
		head=head->next;
		
		//delete(temp);
	}else{
		tail=NULL;
	}
	
	count--;	
	
	//return temp->data;
}
template<class T>
bool queue<T>::isEmpty(){
	//bool queue::isEmpty(){
	return count==0;
}

template<class T>
T queue<T>::getHead(){
	//zanlind queue::getHead(){
	return head->data;
}
#endif
