#include<iostream>
using namespace std;
int main()
{
	int i=0,j=0,n;
	cout<<"��������������������0�������:\n";
	cin>>n;
	while(n!=0)
	{
		n>0?i++:j++;
		cin>>n;
	}
	cout<<"����������:"<<i<<"\t����������:"<<j<<endl;
}