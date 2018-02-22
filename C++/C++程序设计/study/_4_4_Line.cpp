#include<iostream>
#include<cmath>
using namespace std;
class Point
{
	public:
		Point(int xx=0,int yy=0){X=xx;Y=yy;}
		Point(Point &p);
		int GetX(){return X;}
		int GetY(){return Y;}
	private:
		int X,Y;
};
Point::Point(Point &p)
{
	X=p.X;
	Y=p.Y;
	cout<<"Point拷贝构造函数被调用"<<endl;
}
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
	cout<<"Line拷贝构造函数被调用"<<endl;
	len=L.len;
}
int main()
{
	Point myp1(1,1),myp2(4,5);
	Line line(myp1,myp2);
	Line line2(line);
	cout<<"The length of the line is:";
	cout<<line.GetLen()<<endl;
	cout<<"The length of the line2 is:";
	cout<<line2.GetLen()<<endl;
}