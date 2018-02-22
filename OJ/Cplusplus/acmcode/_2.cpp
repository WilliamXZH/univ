#include<iostream>
using namespace std;
int main(){
	int t;
	cin>>t;
	for(int i=0;i<t;i++){
		int n,x,y;
		int s[1000];
		memset(s,0,sizeof(s));
		bool res = true;
		cin>>n>>x>>y;
		for(int j=0;j<n;j++){
			int c;
			cin>>c;
			for(int k=0;k<c;k++){
				int id;
				cin>>id;
				s[id]++;
			}
		}
		int total = 0;
		for(int l=1;l<=1000;l++){
			if(s[l]>0){
				total++;
				if(s[l]>x){
					res = false;
				}
			}
		}
		if(total>y){
			res = false;
		}

		if(res){
			cout<<"NO"<<endl;
		}else{
			cout<<"YES"<<endl;
		}
	}
}