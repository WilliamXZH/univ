#include<iostream>
#include<cmath>
#include<iomanip>
using namespace std;

int main(){
	int l,r;
	cin>>l>>r;
	double rad = (double)l/r;
	cout<<setprecision(3)<<std::fixed<<r*cos(rad)<<' '<<r*sin(rad)<<endl;
	cout<<r*cos(rad)<<' '<<-r*sin(rad)<<endl;
}