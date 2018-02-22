#include<iostream>
#include<math.h>
using namespace std;

void test(long n){
	//long n;
	//cin>>n;
	int k;
	long r0 = (long)sqrt(n*2);
	//cout<<(long)sqrt(n*2)<<endl;
	for(int i=1;;i++){
		n -= i;
		if(n<=0){
			k = i;
			break;
		}
	}
	//cout<<k<<endl;
	if(r0!=k)cout<<r0<<' '<<k<<endl;
}

int main(){
	for(int i=1;i<10;i++){
		cout<<i<<":";
		test(i);
		cout<<endl;
	}
}