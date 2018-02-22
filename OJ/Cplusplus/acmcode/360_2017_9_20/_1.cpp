#include<iostream>
using namespace std;

void print(int a[],int n){
	for(int i=0;i<n;i++){
		cout<<a[i]<<' ';
	}
	cout<<endl;
}

int main(){
	int n,t;
	int i,j,k;
	cin>>n>>t;
	int *a = new int[n];
	for(i=0;i<n;i++){
		cin>>a[i];
	}

	for(i=0;i<n;i++){
		for(int j=0;j<n-1-i;j++){
			if(a[j]>a[j+1]){
				int tmp = a[j];
				a[j] = a[j+1];
				a[j+1] = tmp;
			}
		}
	}
	print(a,n);

	int c = -1;
	for(;c<n-1&&a[c+1]<t;c++);
	int s =0;
	if(c==n-1)c--;
	for(i=c;c>=0;c--){
		if(s+a[c]<t){
			s += a[c];
		}
	}
	s += a[n-1];
	cout<<s<<endl;

}