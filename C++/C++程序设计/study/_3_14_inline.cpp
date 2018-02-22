#include<iostream>
using namespace std;
inline double CalArea(double radius)
{
	return 3.14*radius*radius;
}
int main()
{
	double  r(3.0);
	double area;
	area=CalArea(r);
	cout<<area<<endl;
}