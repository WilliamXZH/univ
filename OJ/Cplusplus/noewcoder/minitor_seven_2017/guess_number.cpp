#include<iostream>
using namespace std;

long getLegalCount(int n);
bool testIfPrime(int x);
bool testIfContained(int x,int y,int n);

int main()
{
	int n;
	cin>>n;
	cout<<getLegalCount(n)%1000000007;
}

bool testIfPrime(int x){
	
	int i;
	for(i=2;i*i<=x;i++){
		if(x%i==0){
			break;
		}
	}
	return i*i>x;
}

bool mtPower(int x,int y,int n){
	int res = 1;
	for(int i=0;i<y;i++){
		res *= x;
	}
	return res<=n;
}

long getLegalCount(int n){
	long c = 1;
	for(int i=n;i>1;i--){
		int divided;
		int divisor;
		//cout<<i<<'\t'<<c<<endl;
		if(testIfPrime(i)){
			divided=2;
			divisor=1;
			for(int j=2;mtPower(i,j,n);j++){
				divided = (divided+1)*2;
				divisor *=2;
			}
			c = c/divisor*divided;
		}else{
			continue;
		}
	}
	return c;
}