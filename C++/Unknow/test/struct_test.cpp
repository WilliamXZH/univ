#include<iostream>
using namespace std;

struct test
{
	private:
		int a;
		int b;
	public:
		int c;
		int d;
};

int main(){
	struct test t;
	cout<<t.a<<endl;
}