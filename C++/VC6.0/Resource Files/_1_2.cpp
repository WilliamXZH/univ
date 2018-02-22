#include<iostream>
using namespace std;
class Figure
{
	protected:
		float x,y;
	public:
		void Set(float i,float j=0)
		{
			x=i;
			y=j;
		}
		void ShowArea(){};

};
class Triangle:public Figure
{
	public:
		void virtual ShowArea()
		{
			cout<<"Triangle with height 12  and base 8 has ans area of "<<x*y/2<<endl;
		}
};
class Square:public Figure
{
	public:
		void ShowArea()
		{
			cout<<"Square with dimension 12*8 as an area of "<<x*y<<endl;
		}
};
class Circle:public Figure
{
	public:
		void Set(float i){x=i;}
		void ShowArea()
		{
			cout<<"Circle with radius 10 has an area of "<<3.14*x*x<<endl;
		}
};
void main()
{
	Figure *p[3];
	Triangle t;
	Square s;
	Circle c;
	p[0]=&t;
	p[0]->Set(12.0,8.0);
	p[1]=&s;
	p[1]->Set(12.0,8.0);
	p[2]=&c;
	p[2]->Set(10.0);
	for(int i=0;i<3;i++)
		p[i]->ShowArea();
}