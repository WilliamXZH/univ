#include<iostream>
using namespace std;

int * getPointer(int &a){
	return &a;
}

int main(){
	int a = 1;
	*getPointer(a)=2;
	cout<<a<<endl;
	int b = 3;
	int c = a++ + ++b;

	int i = 1;
	++i = i++;
	//i++ = ++i;
}