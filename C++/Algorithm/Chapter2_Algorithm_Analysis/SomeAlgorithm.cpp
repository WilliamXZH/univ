#include<iostream>
using namespace std;

int binarySearch(const int a[],int n,int x){
	int low,mid,high;
	low = 0;
	high = n-1;
	while(low<=high){
		mid = (low+high)/2;
		if(a[mid]<x){
			low = mid+1;
		}else if(a[mid]>x){
			high = mid-1;
		}else{
			return mid;
		}
	}
	return -1;
}

unsigned int gcd(unsigned int m, unsigned int n){
	unsigned int rem;
	while(n>0){
		rem = m%n;
		m = n;
		n = rem;
	}
	return m;
}

int main(){
	int a[] = {1,3,4,5,7,8,9};
	cout<<binarySearch(a,7,9)<<endl;
	cout<<gcd(999,2349432)<<endl;
}