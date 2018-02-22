#include<iostream>
using namespace std;

#define squ(x) (x*x)

#define pow(x,y) int ext=1;for(;y!=0;)y%2==0?(x*=x,y/=2):(ext*=x,y-=1;);x*ext;

//#define pow(x,y) (y==1?x:(y==2?squ(x):(y%2==0?pow2(squ(x),y/2):pow2(x,y-1)*x)))
//#define pow2(x,y) (y==1?x:(y==2?squ(x):(y%2==0?pow(squ(x),y/2):pow(x,y-1)*x)))

int main(){
	cout<<squ(2)<<endl;
	int a=(1*2,3,2);
	cout<<a<<endl;
	cout<<pow(2,7)<<endl;
}