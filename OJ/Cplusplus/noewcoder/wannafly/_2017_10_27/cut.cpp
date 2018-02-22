#include<iostream>
using namespace std;

int main(){
	int n,i,j;
	cin>>n;
	int *a = new int[n];
	long s = 0;
	for(i=0;i<n;i++){
		cin>>a[i];
		s += a[i];
	}

	for(i=0;i<n;i++){
		for(j=n-1;j>i;j--){
			if(a[j]<a[j-1]){
				int tmp = a[j];
				a[j] = a[j-1];
				a[j-1] = tmp;
			}
		}
		
	}
	long sum = 0;
	for(i=0;i<n-1;i++){
		sum += s;
		s -= a[i];
	}
	printf("%lld",sum);
}