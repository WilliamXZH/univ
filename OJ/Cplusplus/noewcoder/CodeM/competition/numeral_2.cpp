#include<iostream>
using namespace std;

int l,r;
int a[9]={0};

void dfs(int h, int t){

	//cout<<h<<":"<<t<<":"<<a[h-1]<<endl;
	if(t>r){
		return;
	}	
	if(l%t==0){
		a[h-1] += (r-l)/t+1;
	}else{
		a[h-1] += (r-l+l%t)/t;
	}

	for(int i=0;i<10;i++){
		dfs(h, t*10+i);
	}
}

int main(){
	cin>>l>>r;
	
	//cout<<l<<":"<<r<<endl;

	for(int i=1;i<10;i++){
		dfs(i,i);

		cout<<a[i-1];
		if(i!=9){
			cout<<endl;
		}
	}

}