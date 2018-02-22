#include<iostream>
using namespace std;
void display(const double & r);
int main(){
	double d(9.5);
	display(d);
	cout<<d<<endl;
}
void display(const double& r)
{
	cout<<r<<endl;
}