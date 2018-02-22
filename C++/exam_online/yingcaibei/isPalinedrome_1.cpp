#include<iostream>
using namespace std;
int is(int x);
int main(){
	
	cout<<is(123321)<<endl;
	cout<<is(12345)<<endl;
	cout<<is(12321)<<endl;
	cout<<is(123210)<<endl;
	cout<<is(-1234321)<<endl;
	cout<<is(002)<<endl;
	cout<<is(1000000001)<<endl;
	cout<<is(1410110141)<<endl;
	/*for(int i=0;i<100000;i++)
		if(is(i))cout<<i<<" ";*/
}
int is(int x){
	int tmp=1;
	if(x<0)return false;
	for(;x/tmp/10;tmp*=10);
	for(;x;tmp/=100){
		if(x/tmp!=x%10)return false;
		else x=x%tmp/10;
	}
	return true;
}