#include<iostream>
using namespace std;
int main()
{
	int i=0,j=0,n;
	cout<<"请输入若干整数（输入0则结束）:\n";
	cin>>n;
	while(n!=0)
	{
		n>0?i++:j++;
		cin>>n;
	}
	cout<<"正整数个数:"<<i<<"\t负整数个数:"<<j<<endl;
}