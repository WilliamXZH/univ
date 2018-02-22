#include "Stack.h"


template<class T>
stack<T>::stack(){
//stack::stack(){
	init();
}
template<class T>
stack<T>::~stack(){

}


template<class T>
void stack<T>::init(){
//void stack::init(){
	top=-1;
	memset(eleStack,0,sizeof(eleStack));
}
template<class T>
void stack<T>::empty(){
//void stack::empty(){
	if(top>=0){
		pop();
	}
}

template<class T>
void stack<T>::push(T ele){
//void stack::push(zanlind ele){
	if(top>=MAXELE){
		//throw error;
	}else{
		eleStack[++top]=ele;
	}
}

template<class T>
int stack<T>::size(){
//int stack::size(){
	return top+1;
}

template<class T>
bool stack<T>::pop(){
//bool stack::pop(){
	if(top<0){
		return false;
		//error;
	}
	
	//T temp=eleStack[top];
	
	memset(&eleStack[top],0,sizeof(T));
	top--;
	return true;

}
template<class T>
bool stack<T>::isFull(){
//bool stack::isFull(){
	return top==MAXELE;
}

template<class T>
bool stack<T>::isEmpty(){
//bool stack::isEmpty(){
	return top==-1;
}

template<class T>
T stack<T>::getTop(){
//zanlind stack::getTop(){
	return eleStack[top];
}

