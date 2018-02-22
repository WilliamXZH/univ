#include "Queue.h"

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
	QueueNode *newNode=new QueueNode();

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
bool queue<T>::pop(){
//bool queue::pop(){
	QueueNode *temp;

	if(head!=NULL){	
		temp=head;
		head=head->next;

		delete(temp->data);
		//delete(temp);
	}else{
		tail=NULL;
	}

	count--;	

	return true;
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