#include<iostream>
using namespace std;
class complex
{
	public:
		complex(double r=0.0,double i=0.0){real=r;imag=i;}
		friend complex operator + (complex c1,complex c2);
		friend complex operator - (complex c1,complex c2);
		void display();
	private:
		double real;
		double imag;
};
complex operator +(complex c1,complex c2)
{
	return complex(c1.real+c2.real,c1.imag+c2.imag);
}
complex operator -(complex c1,complex c2)
{
	return complex(c1.real-c2.real,c1.imag-c2.imag);
}
void complex::display()
{
	cout<<"("<<real<<","<<imag<<")"<<endl;
}
int main()
{
	complex c1(5,4),c2(2,10),c3;
	cout<<"c1=";
	c1.display();
	cout<<"c2=";
	c2.display();
	cout<<"c3=";
	c3.display();
	c3=c1-c2;
	cout<<"c3=c1-c2=";
	c3.display();
	c3=c1+c2;
	cout<<"c3=c1-c2=";
	c3.display();
}
