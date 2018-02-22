#include<iostream>
using namespace std;

void heapAdjust(int a[],int s,int n){
	int tmp = a[s];
	long child = 2*s+1;
	while(child<n){
		if(child+1<n&&a[child]<a[child+1]){
			++child;
		}
		if(a[s]<a[child]){
			a[s] = a[child];
			s = child;
			child = 2*s+1;
		}else{
			break;
		}
		a[s] = tmp;
	}
}

int main(){
	int n,i,j;
	cin>>n;
	int *a = new int[n];
	int s = 0;
	for(i=0;i<n;i++){
		cin>>a[i];
		s += a[i];
	}
	
	for(i=(n-1)/2;i>=0;i--){
		heapAdjust(a,i,n);
	}

	long sum = 0;
	for(j=n-1;j>0;j--){
		int tmp = a[j];
		a[j] = a[0];
		a[0] = tmp;
		heapAdjust(a,0,j);
	}
	for(i=0;i<n-1;i++){
		sum += s;
		s -= a[i];
	}
	printf("%lld",sum);
}