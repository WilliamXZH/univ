#include<iostream>
#include "point.cpp"
ostream &operator<<(ostream& outs,Point p)
{
	outs<<"<"<<p.GetX()<<", "<<px.GetY()<<">";
	return outs;
}
istream operator<<(istream& ins,Point p)
{
	int x,y;
	ins>>x>>y;
	p.SetX(x);
	p.SetY(y);
}
void main()
{
}