#include<iostream>
#include<iomanip>
#include<process>
using namespace std;
template <class T>
class array
{
	public:
		array(int size);
		~array(){delete []a;}
		T get(int i);
		void set(T t,int i);
	protected:
		int len;
		T *a;
};
template<class T
{
};>