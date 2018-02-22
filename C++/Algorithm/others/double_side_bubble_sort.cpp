#include<iostream>
using namespace std;

int main(){
	int a[10] = {2,4,6,8,0,1,3,5,7,9};
	int i=0,j=9,k;
	bool flag = true;
	while(flag){
		flag = false;
		for(k=i;k<j;k++){
			if(a[k]>a[k+1]){
				flag = true;
				int tmp = a[k];
				a[k] = a[k+1];
				a[k+1] = tmp;
			}
		}
		--j;
		for(k=j;k>i;k--){
			if(a[k]<a[k-1]){
				flag = true;
				int tmp = a[k];
				a[k] = a[k-1];
				a[k-1] = tmp;
			}
		}
		++i;
	}
	for(k=0;k<10;k++){
		cout<<a[k]<<' ';
	}
}