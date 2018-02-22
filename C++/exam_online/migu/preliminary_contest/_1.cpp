#include<iostream>
using namespace std;
int main(){
	int m,n,i,j;
	cin>>n>>m;
	for(i=2;i<=m;i++){
		if(m%i==0&&n%i==0){
			for(j=0;j<i;j++){
				cout<<n/i;
				if(j!=i-1)cout<<" ";
			}
			return;
		}
	}
	for(i=2;i<=m;i++){
		//cout<<i<<" "<<m%i<<" "<<n%i<<endl;
		if(m%i==0&&i>n%i){
			for(j=0;j<i;j++)
			{
				if(j<n%i)cout<<n/i+1;
				else cout<<n/i;
				if(j!=i-1)cout<<" ";
			}
			break;
		}
	}

}