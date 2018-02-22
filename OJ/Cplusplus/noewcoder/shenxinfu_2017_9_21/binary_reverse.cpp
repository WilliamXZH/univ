#include<iostream>
using namespace std;

unsigned int reverse(unsigned int num)
{
    unsigned int t = num;
    unsigned int c = 0;
    for(int i=0;i<32;i++){
        c = c*2+t%2;
		t  = t>>1;
    }
    return c;
    //TODO:
}

int main(){
	unsigned int a = 0x1;
	printf("%x\n",reverse(a));
}