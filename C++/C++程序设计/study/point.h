#include<iostream>
using namespace std;

#if !defined(_POINT_H)
#define _POINT_H
class Point
{
	public:
		Point();
		Point(int xx=0,int yy=0);
		Point(Point &p);
		~Point();
		void Move(int x,int y);
		float GetX(){return X;}
		float GetY(){return Y;}
		static void GetC(){cout<<"Object id="<<countP<<endl;}
	private:
		float X,Y;
		static int countP;
};
#endif