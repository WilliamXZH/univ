#include<iostream>
using namespace std;

void splitfloat(float x,int *intpart,float *fracpart)
{
	*intpart=int(x);
	*fracpart=x-*intpart;
}
int main()
{
	int i,n;
	float x,f;
	cout<<"Enter 3 float point numbers:"<<endl;
	for(i=0;i<3;i++)
	{
		cin>>x;
		splitfloat(x,&n,&f);
		cout<<"Integer Part = "<<n<<" Fraction Part= "<<f<<endl;
	}
}