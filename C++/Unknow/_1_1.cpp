#include<iostream>
using namespace std;
void swap(int *a,int *b)
{
	int c;
	c=*a;
	*a=*b;
	*b=c;
}
int main()
{
	int x,y;
	while(1)
	{
		cin>>x>>y;
		swap(&x,&y);
		cout<<"x="<<x<<endl;
		cout<<"y="<<y<<endl;
	}
}