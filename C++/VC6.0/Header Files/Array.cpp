#include<iostream>
#include<vector>
using namespace std;
template<class T>
class Array
{
	private:
		T *pArray;
		int size;
	public:
		Array(int sz=0){size=0;pArray=new T[size];}
		~Array(){delete[]pArray;}
		T& operator[](int index);
};
int main()
{
	int n;
	cin>>n;
	vector<int> a(n);
	int m=20144800;
	for(int i=0;i<n;i++)
	{
		a[i]=m;
		m++;
		cout<<a[i]<<'\t';
	}

}