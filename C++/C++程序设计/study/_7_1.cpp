#include<iostream>
#include<cmath>
#include"rectangle.h"
using namespace std;
int main()
{
	Rectangle rect;
	rect.InitR(2,3,20,10);
	rect.Move(3,2);
	cout<<"The data of rect(X,Y,W,H):"<<endl;
	cout<<rect.GetX()<<","
		<<rect.GetY()<<","
		<<rect.GetW()<<","
		<<rect.GetH()<<endl;
}
//End of 7_1.cpp