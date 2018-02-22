#include<iostream>
using namespace std;
class Point
{
	private:
		int x,y;
	public:
		Point(int px=0,int py=0)
		{
			x=px;
			y=py;
		}
		void SetX(int px){x=px;}
		int GetX(){return x;}
		void SetY(int py){y=py;}
		int GetY(){return y;}
		ShowPoint()
		{
			cout<<"X:"<<x<<"Y:"<<y<<endl;
		}
};