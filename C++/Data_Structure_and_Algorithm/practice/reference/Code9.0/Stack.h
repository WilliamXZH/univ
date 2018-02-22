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
	ArrayStack(int s = MAX);	//Ĭ�ϵ�ջ����Ϊ5
	~ArrayStack();
	
public:
	T top();			//��ȡջ��Ԫ��
	void push(T t);		//ѹջ����
	T pop();			//��ջ����
	bool isEmpty();		//�пղ���
	bool isFull();
	int getSize();			//��ջ�Ĵ�С
	void Stackkk();
private:
	int count;			//ջ��Ԫ������
	int capacity;		//ջ������
	T * array;			//�ײ�Ϊ����
};

/*���캯��*/
template <typename T>
 ArrayStack<T>::ArrayStack(int s)
	 :count(0), capacity(s), array(NULL)//array(nullptr)
 {
	 array = new T[capacity];
 };

 /*��������*/
 template<typename T>
 ArrayStack<T>::~ArrayStack()
 {
	 if (array)
	 {
		 delete[]array;
		 array =NULL;// nullptr;
	 }
 };

 /*ջ���пղ���*/
 template <typename T>
 bool ArrayStack<T>::isEmpty()
 {
	 return count == 0; //ջԪ��Ϊ0ʱΪջ��
 };

  /*ջ����������*/
 template <typename T>
 bool ArrayStack<T>::isFull()
 {
	 if (count == capacity)return true;
	 else return false;
	 
 };

 /*����ջ�Ĵ�С*/
 template <typename  T>
 int ArrayStack<T>::getSize()
 {
	 return count;
 };

 /*����Ԫ��*/
 template <typename T>
void ArrayStack<T>::push(T t)
 {
	 if (count != capacity)	//���ж��Ƿ�ջ��
	 {
		 array[count++] = t;	
	 }
 };

/*��ջ*/
 template <typename T>
 T ArrayStack<T>::pop()
 {
	 if (count != 0)	//���ж��Ƿ��ǿ�ջ
	 {
		 return array[--count];
	 }
 };

 /*��ȡջ��Ԫ��*/
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