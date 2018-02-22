#include<iostream>
#include<cmath>
using namespace std;
int main(){
	int n,i,j;
	do{
		cin>>n;
	}while(n<1||n>50);
	for(i=8;i>=(n/8+(n%8?1:0));i--){
		if(n%i==0){
			for(j=0;j<n/i;j++){
				cout<<i;
				if(j!=n/i-1)cout<<"\n";
			}
			return;
		}
	}
	for(i=7;i>=(n/8+(n%8?1:0));i--){
		if(n/i>n%i){
			for(j=0;j<n/i;j++){
				if(j<n%i)cout<<i+1;
				else cout<<i;
				if(j!=n/i-1)cout<<"\n";
			}
			break;
		}
	}

}