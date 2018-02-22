#ifndef STACK_H
#define STACK_H
#include<iostream>
using namespace std;
#define MAX 5




//////////////////////////////////////
template<typename T>
class ArrayStack
{
public:
	ArrayStack(int s = MAX);	//默认的栈容量为5
	~ArrayStack();
	
public:
	T top();			//获取栈顶元素
	void push(T t);		//压栈操作
	T pop();			//弹栈操作
	bool isEmpty();		//判空操作
	bool isFull();
	int getSize();			//求栈的大小
	void Stackkk();
private:
	int count;			//栈的元素数量
	int capacity;		//栈的容量
	T * array;			//底层为数组
};

/*构造函数*/
template <typename T>
 ArrayStack<T>::ArrayStack(int s)
	 :count(0), capacity(s), array(NULL)//array(nullptr)
 {
	 array = new T[capacity];
 };

 /*析构函数*/
 template<typename T>
 ArrayStack<T>::~ArrayStack()
 {
	 if (array)
	 {
		 delete[]array;
		 array =NULL;// nullptr;
	 }
 };

 /*栈的判空操作*/
 template <typename T>
 bool ArrayStack<T>::isEmpty()
 {
	 return count == 0; //栈元素为0时为栈空
 };

  /*栈的判满操作*/
 template <typename T>
 bool ArrayStack<T>::isFull()
 {
	 if (count == capacity)return true;
	 else return false;
	 
 };

 /*返回栈的大小*/
 template <typename  T>
 int ArrayStack<T>::getSize()
 {
	 return count;
 };

 /*插入元素*/
 template <typename T>
void ArrayStack<T>::push(T t)
 {
	 if (count != capacity)	//先判断是否栈满
	 {
		 array[count++] = t;	
	 }
 };

/*弹栈*/
 template <typename T>
 T ArrayStack<T>::pop()
 {
	 if (count != 0)	//先判断是否是空栈
	 {
		 return array[--count];
	 }
 };

 /*获取栈顶元素*/
 template <typename T>
 T ArrayStack<T>::top()
 {
	 if (count != 0)
	 {
		 return array[count - 1];
	 }
 };
//////////////////////////////////////
#endif