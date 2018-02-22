#include<iostream>
using namespace std;
template<class T>
class Array
{
private:
	T *pArray;
	int size;
public:
	Array(int sz=0){size=sz;pArray=new T[sz];}
	~Array(){delete[]pArray;}
	T& operator[](int index){return pArray[index];}
};
void main()
{
	Array<char> p(51);
	p[0]='a';
	for(int i=0;i<50;i++){
		cout<<" "<<p[i]<<'\t';
		p[i+1]=p[i]+1;
	}
}