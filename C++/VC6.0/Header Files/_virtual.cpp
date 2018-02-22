#include<iostream>
using namespace std;
class CShape
{
	public:
		double r,s;
		CShape(double x){r=x;}
		virtual void display()=0;
};