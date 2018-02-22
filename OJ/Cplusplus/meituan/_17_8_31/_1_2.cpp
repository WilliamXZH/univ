#include<iostream>
using namespace std;
int main(){
	int n,k;
	cin>>n;
	int *p = new int[n];
	int sum = 0;
	int tc = 0;
	int c = 0;
	for(int i=0;i<n;i++){
		cin>>p[i];
	}
	cin>>k;
	for(int j=0;j<n;j++){
		if(p[j]%k==0){
			c++;
		}else{
			sum += p[j];
			tc ++;
			//cout<<sum<<":"<<p[j]<<endl;
			if(sum%k==0){
				sum = 0;
				c += tc;
			}
		}
	}
	cout<<c<<endl;
}