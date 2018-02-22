#include<iostream>
using namespace std;
class Point
{
	public:
		Point(int xx=0,int yy=0){X=xx;Y=yy;};
		Point(Point &p);
		int GetX(){return X;}
		int GetY(){return Y;}
		~Clock(){}
	private:
		int X,Y;
};
Point::Point(Point &p)
{
	X=p.X;
	Y=p.Y;
	cout<<"拷贝构造函数被调用"<<endl;
}
void f(Point p)
{
	cout<<p.GetX()<<endl;
}
Point g()
{
	Point A(1,2);
	return A;
}
int main()
{
	Point A(4,5);
	Point B(A);
	cout<<B.GetX()<<endl;
	f(B);
	B=g();
	cout<<B.GetX()<<endl;
	return 0;
}
