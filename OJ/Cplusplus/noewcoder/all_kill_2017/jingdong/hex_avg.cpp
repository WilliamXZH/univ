#include<iostream>
using namespace std;

int gcd(int a,int b){
	while(b){
		a = a%b;
		a = a^b;
		b = a^b;
		a = a^b;
	}
	return a;
}

int hexSum(int n,int a){
	int res = 0;
	while(n){
		res += n%a;
		n /= a;
	}
	return res;
}

int main(){
	int x;
	int sum = 0;
	//cout<<gcd(21,0)<<endl;
	while(cin>>x){
		for(int i=2;i<x;i++){
			sum += hexSum(x,i);
		}
		int r = gcd(sum,x-2);

		if(r!=0)cout<<sum/r<<'/'<<(x-2)/r<<endl;

	}
}