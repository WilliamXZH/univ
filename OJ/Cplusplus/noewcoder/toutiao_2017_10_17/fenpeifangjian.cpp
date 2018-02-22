#include<iostream>
using namespace std;

int main(){
	int n,x;
	cin>>n>>x;
	int *a = new int[n];
	int m = 0;
	for(int i=0;i<n;i++){
		cin>>a[i];
		if(a[i]<=a[m]){
			m = i;
		}
	}
	int c = a[m];
	int j = m>0?m-1:n-1;
	bool f = false;
	while(j!=m){
		if(j==x-1){
			f = true;
		}
		if(f){
			a[j] -= (c+1);
			a[m] += (c+1);
		}else{
			a[j] -= c;
			a[m] += c;
		}
		if(j>0){
			j--;
		}else{
			j = n-1;
		}
	}
	for(int k=0;k<n;k++){
		cout<<a[k];
		if(k<n-1){
			cout<<' ';
		}
	}

}