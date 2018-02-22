#include<iostream>
using namespace std;

bool test(int n){
	int t = 0;
	int c = 0;
	int m = 1;
	while(n/m!=0){
		c ++;
		t += m%10;
		m *= 10;
	}

	m/=10;
	for(int i=c-1;i<c;i++){
		int s = 10;
		for(int j=0;j<i;j++){
			if(n%(s+1)==0){
				return true;
			}
		}

	}
}

int main(){
	int l,r;
	cin>>l>>r;
	int c = 0;
	for(int i=l;i<=r;i++){
		
	}
	cout<<c<<endl;
}