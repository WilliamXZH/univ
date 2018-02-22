#include<iostream>
#include<iomanip>
using namespace std;

int max(int x,int y)
{
	return x>y?x:y;
}
void pre(int **p,int x,int y)
{
	for(int i=0;i<x;i++)
	{
		cout<<"�������"<<i+1<<"�е�"<<y<<"����"<<endl;
		for(int j=0;j<y;j++)
			cin>>p[i][j];
	}
}
void print(int **p,int x,int y)
{
	for(int i=0;i<x;i++)
	{
		cout<<"|";
		for(int j=0;j<y;j++)
			cout<<setiosflags(ios_base::left)<<setw(3)<<p[i][j];
		cout<<"|"<<endl;
	}
}
void trans(int **p,int l)
{
	int temp;
	for(int i=0;i<l;i++)
	{
		for(int j=i+1;j<l;j++)
		{
			temp=p[i][j];
			p[i][j]=p[j][i];
			p[j][i]=temp;
		}
	}
}
void main()
{
	int m,n,l,**p;
	cout<<"�������Ĵ�С:"<<endl;
	cin>>m>>n;
	l=max(m,n);
	p=new int*[l];
	for(int i=0;i<l;i++)
		p[i]=new int[l];
	pre(p,m,n);
	cout<<"ת��֮ǰ�ľ���"<<endl;
	print(p,m,n);
	trans(p,l);
	cout<<"ת��֮��:"<<endl;
	print(p,n,m);
	delete p;
}
