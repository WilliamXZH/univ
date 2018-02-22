#include<iostream>
#include"point.cpp"
using namespace std;
int main()
{
	cout<<"Entering main..."<<endl;
	Point A[2];
	for(int i=0;i<2;i++)
		A[i].Move(i+10,i+20);
	cout<<"Exiting main..."<<endl;
}