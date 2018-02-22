#include<iostream>
using namespace std;
#define N 10
int main(){
	int numbers[N];
	int i,j,k,tem;
	for(i=0;i<N;i++)cin>>numbers[i];
	for(i=0;i<N-1;i++){
		for(j=N-1;j>=i;j--){
			if(numbers[j-1]<numbers[j]){
				tem=numbers[j-1];
				numbers[j-1]=numbers[j];
				numbers[j]=tem;
			}
		}
		cout<<numbers[i]<<" ";
	}
	cout<<numbers[i]<<endl;
	cin>>k;
	cout<<numbers[k-1]<<endl;;
}