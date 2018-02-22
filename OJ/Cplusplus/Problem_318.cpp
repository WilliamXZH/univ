#include<iostream>
using namespace std;
int main(){
	int n,m,tmp,res;
	cin>>n;
	for(int i=0;i<n;i++){
		cin>>m;
		res=0;
		for(int j=0;j<m;j++){
			cin>>tmp;
			res+=tmp;
		}
		cout<<res<<endl;
	}
}