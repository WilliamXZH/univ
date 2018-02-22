#include "Point.h"
class Line
{
	public:
		Line(Point xp1,Point xp2);
		Line(Line &);
		double GetLen(){return len;}
	private:
		Point p1,p2;
		double len;
};
Line::Line(Point xp1,Point xp2):p1(xp1),p2(xp2)
{
	cout<<"Line构造函数被调用"<<endl;
	double x=double(p1.GetX()-p2.GetX());
	double y=double(p1.GetY()-p2.GetY());
	len=sqrt(x*x+y*y);
}
Line::Line(Line &L):p1(L.p1),p2(L.p2)
{
	cout<<"Line拷贝构造函数被调用"<endl;
	len=L.len;
}