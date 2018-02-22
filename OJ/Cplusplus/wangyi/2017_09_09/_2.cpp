#include<iostream>
using namespace std;

int main(){
	int t;
	cin>>t;
	while(t--){
		int n;
		cin>>n;
		int c1=0,c2=0,tmp;
		//int *a = new int[n];
		for(int i=0;i<n;i++){
			cin>>tmp;
			if(tmp%4==0){
				c1++;
			}else if(tmp%2==0){
				c2++;
			}
		}
		if((n-c2)/2<=c1){
			cout<<"Yes"<<endl;
		}else{
			cout<<"No"<<endl;
		}
	}
}