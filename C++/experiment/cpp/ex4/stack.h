#include<iostream>
using namespace std;
template<class T>
class Stack{
	private:
		T *stack;
		int tos;
		static const int SIZE;
	public:
		Stack();
		~Stack();
		void Push(T &n);
		T Pop();
};
template<class T>
const int Stack<T>::SIZE=128;
template<class T>
Stack<T>::Stack(void):tos(0){stack=new T[SIZE];}
template<class T>
Stack<T>::~Stack(){delete[] stack;}
template<class T>
void Stack<T>::Push(T& n){
	cout<<tos<<'\0'<<n<<'\t'<<SIZE<<endl;
	if(tos>=SIZE){
		cout<<"Stack overflow!"<<endl;
		return;
	}
	stack[tos++]=n;
}
template<class T>
T Stack<T>::Pop(){
	if(tos<=0){
		cout<<"Attempt to pop an empty stack!"<<endl;
		return NULL;
	}
	return stack[--tos];
}