#include<iostream>
#include<list>
using namespace std;
template<class T>
class List
{
	public:
		List();
		void Add(T& t);
		void Remove(T& t);
		T* Find(T &t);
		void PrintList();
		~List();
	protected:
		struct Node
		{
			Node *pNext;
			T* pT;
		};
		Node *pFirst;
};