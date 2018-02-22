#include<iostream>
using namespace std;

int main(){
	int a[] ={2,4,5,6,1,7};
	for(int i=0;i<6;i++){
		for(int j=5;j>0;j--){
			if(a[j]<a[j-1]){
				int tmp = a[j];
				a[j] = a[j-1];
				a[j-1] = tmp;
			}
		}
		cout<<a[i]<<endl;
	}
}