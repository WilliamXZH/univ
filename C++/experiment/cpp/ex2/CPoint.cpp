#include"CPoint.h"

int main()
{
	CPoint a(3,4),b(a),*c=&a,&d=a,e,f;
	cout<<"test:a(3,4),b(a),*c=&a,&d=a,e"<<endl;
	cout<<"a:"<<"<"<<a.GetX()<<","<<a.GetY()<<">_";
	a.ShowPoint();
	cout<<"c:";
	c->ShowPoint();
	cout<<"b:";
	b.SetX(2);b.SetY(5);
	b.ShowPoint();
	cout<<"d:";d.ShowPoint();
	e=a+b;
	cout<<"e=a+b:";e.ShowPoint();
	e=a-b;
	cout<<"e=a-b:";e.ShowPoint();
	cout<<"f=";
	cin>>f;
	cout<<f;
}