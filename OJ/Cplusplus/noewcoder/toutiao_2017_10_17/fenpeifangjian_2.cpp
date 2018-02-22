#include<iostream>
using namespace std;

int main(){
	int n,x;
	cin>>n>>x;
	x--;
	int *a = new int[n];
	int m = 0;
	for(int i=0;i<n;i++){
		cin>>a[i];
		if(a[i]<=a[m]){
			m = i;
		}
	}
	int c = a[m];
	for(int k=0;k<n;k++){
		if(k==m){
			int d = x>=m?(x-m):(x+n-m);
			a[k] = c*n+d;
		}else{
			a[k] -= c;
			if(x>=m){
				if(k>m&&k<=x){
					a[k]--;
				}
			}else{
				if(k<=x||k>m){
					a[k]--;
				}
			}
		}
		cout<<a[k];
		if(k<n-1){
			cout<<' ';
		}
	}

}