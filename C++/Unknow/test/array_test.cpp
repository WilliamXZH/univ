#include<iostream>
using namespace std;

int main(){
	int a[6][2] = {1,2,3,4,5,6,7,8,9};
	int (*q)[2] = &a[1];
	cout<<q[1][1]<<endl;
	cout<<q[2][2]<<endl;
}