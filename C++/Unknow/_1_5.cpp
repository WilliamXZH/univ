#include<iostream>
using namespace std;
int fun(char *x)
{
	char *y=x;
	while(*y++);
	return y-x-1;
}
int main()
{
	char a[]="adasfas";
	cout<<fun("adasfa")<<endl;

}