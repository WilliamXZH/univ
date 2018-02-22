#include"safearray.h"
template <typename T>
safearray<T>::safearray(const int cap){
	storage=new T[cap];
	capacity=cap;
}

template <class T>
safearray<T>::~safearray(){
	delete[] storage;
	cout<<"destructor called."<<endl;
}
template <class T>
T& safearray<T>::operator[] (const int &t) throw(out_of_range){
	if (t<0){
		throw out_of_range("Index is below 0");
	}else if (t>=capacity){
		throw out_of_range("Index is too high");
	}else {
		return storage[t];
	}
}