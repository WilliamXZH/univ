#include<iostream>
using namespace std;
#define N 10
int main(){
	int numbers[N];
	int i,j,k,l,tem;
	
	memset(numbers,0,sizeof(numbers));
	cin>>k;
	cout<<"output N numbers."<<endl;
	for(i=0;i<N;i++){
		cin>>numbers[i];
		cout<<numbers[i]<<">"<<numbers[k-1]<<"?";
		if(numbers[i]>numbers[k-1]){
			cout<<(numbers[i]>numbers[k-1])<<endl;
			for(j=0;j<i&&j<k-1;j++){
				cout<<(numbers[i]>=numbers[j])<<endl;
				if(numbers[i]>=numbers[j]){
					tem=numbers[i];
					for(l=k-1;l>j;l--){
						numbers[l]=numbers[l-1];
					}
					numbers[j]=tem;
					break;
				}
			}
		}
		for(int j=0;j<N;cout<<numbers[j]<<" ",j++);
		cout<<endl;
	}
	cout<<numbers[k-1];
}