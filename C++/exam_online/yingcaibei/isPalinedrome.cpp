#include<iostream>
using namespace std;
bool is(int x);
int main(){
	/*cout<<is(123321)<<endl;
	cout<<is(12345)<<endl;
	cout<<is(12321)<<endl;*/
	cout<<is(-1234321)<<endl;
	cout<<is(0)<<endl;
	/*for(int i=0;i<10000000;i++)
		if(is(i))cout<<i<<" ";//cout<<i<<"is Palinedrome?"<<is(i)<<endl;*/
}
bool is(int x){
	int tmp=0;
	int z=x;
	if(x<0)return false;
	for(;z!=0;z/=10){
		tmp=tmp*10+z%10;
	}
	return x==tmp
}


