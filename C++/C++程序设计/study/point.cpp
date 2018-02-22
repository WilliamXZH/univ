#include"point.h"
#include<iostream>
using namespace std;
int Point::countP=0;
Point::Point()
{
	X=Y=0;
	countP++;
	cout<<"Default Constructor called."<<endl;
}
Point::Point(int xx,int yy)
{
	X=xx;
	Y=yy;
	cout<<"Constructor called."<<endl;
}
Point::~Point()
{
	countP--;
	cout<<"Deconstructor called."<<endl;
}
void Point::Move(int x,int y)
{
	X=x;
	Y=y;
}

Point::Point(Point &p)
{
	X=p.X;
	Y=p.Y;
	countP++;
}