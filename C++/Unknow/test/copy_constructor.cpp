#include<iostream>
using namespace std;

class test
{
	public:
		test(int a){this->a = a;}
		test(test &t){this->a = t.a+1;cout<<"Copy_Constructor!!!"<<endl;}
		void display(){cout<<this->a<<endl;}
	private:
		int a;
};

int main(){
	test t = 1;
	test s = t;
	s.display();
	//test r(s);

	return 0;
}