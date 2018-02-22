#include<iostream>
using namespace std;
int is(int x);
int main(){
	/*cout<<is(123321)<<endl;
	cout<<is(12345)<<endl;
	cout<<is(12321)<<endl;*/
	cout<<is(-123454321)<<endl;
	//for(int i=0;i<10000000;i++)
	//	if(is(i))cout<<i<<" ";
}
int is(int x){
	int tmp=0;
	while(x>tmp){
		tmp=tmp*10+x%10;
		cout<<x<<" "<<tmp<<endl;
		if(tmp==0)return false;
		x/=10;
	}
	return (x==tmp||x==tmp/10);
}