#include<iostream>
using namespace std;

int main(){
	int a = 2;
	int b = 2;
	int t =(1,2,3);
	cout<<t<<endl;

	a = a^b;
	b = a^b;
	a = a^b;

	cout<<a<<" "<<b<<endl;
}