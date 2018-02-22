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
		cin>>tem;
		for(j=0;j<=i&&j<k;j++){
			if(tem>numbers[j]){
				for(l=k-1;l>j;l--)
					numbers[l]=numbers[l-1];
				numbers[j]=tem;
				break;
			}
		}
		//for(j=0;j<N;j++)cout<<numbers[j]<<" ";
		//cout<<endl;
	}
	cout<<numbers[k-1];
}