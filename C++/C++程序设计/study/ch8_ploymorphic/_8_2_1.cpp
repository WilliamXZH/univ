#include<iostream>
using namespace std;

class complex
{
	public:
		complex(double r=0.0,double i=0.0){real=r;imag=i;}
		void display();
	private:
		double real;
		double imag;
};

int main(){
	complex a(10,20),b(5,8);
	int liv = 1;
	++liv++;
	cout<<liv<<endl;
	//cout<<(++liv++)<<endl;
}