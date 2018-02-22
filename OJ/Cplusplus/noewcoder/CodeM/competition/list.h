#include<iostream>
using namespace std;
#define SIZE 30

template<class T>
class list{
private:
		int l;
		int ptr[SIZE];
		T data[SIZE];
		int head;
		int tail;
public:
	list();
	void init();
	void print();
	void printptr();
	void empty();
	bool isempty();
	bool add(T t);
	bool find(T t);
	bool remove(T t);
	int size();
};
template<class T>
list<T>::list(){
	init();
}
template<class T>
void empty()
{
	init();
};

template<class T>
void list<T>::init(){
	for(int i=0;i<SIZE-1;i++){
		ptr[i]=i+1;
	}
	ptr[SIZE-1]=0;
	head=0;
	tail=ptr[head];
	l=0;
};
template<class T>
int list<T>::size(){
	return l;
};
template<class T>
bool list<T>::isempty(){
	return tail==ptr[head];
};

template<class T>
bool list<T>::add(T t){
	if(ptr[tail]==head){
		return false;
	}else{
		data[tail]=t;
		tail=ptr[tail];
		l++;
	}
	return true;
};

template<class T>
bool list<T>::remove(T t){
	for(int i=head;ptr[i]!=tail;i=ptr[i]){
		if(data[ptr[i]]==t){
			int tmp = ptr[i];
			ptr[i] = ptr[ptr[i]];
			ptr[tmp]=ptr[head];
			ptr[head]=tmp;
			head=tmp;
			l--;
			return true;
		}
	}
	return false;
}

template<class T>
bool list<T>::find(T t){
	if(tail==otr[head])return false;
	for(int i=head;ptr[i]!=tail;i=ptr[i]){
		if(data[ptr[i]]==t){
			return true;
		}
	}
	return false;
}
template<class T>
void list<T>::print(){
	if(tail==ptr[head])return;
	for(int i=head;ptr[i]!=tail;i=ptr[i]){
		cout<<head<<"\t"<<ptr[i]<<":"<<data[ptr[i]]<<"\t"<<tail<<endl;
	}
	cout<<endl;
}
template<class T>
void list<T>::printptr(){
	if(tail==ptr[head])return;
	for(int i=ptr[head];i!=head;i=ptr[i]){
		cout<<i<<":"<<ptr[i]<<endl;
	}
	cout<<head<<":"<<ptr[head]<<endl;
	cout<<endl;
}