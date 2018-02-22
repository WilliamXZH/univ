#include<iostream>
using namespace std;

int get(int p){
	while(p/10!=0){
		p /= 10;
	}
	return p;
}

int main(){
	int l,r;
	cin>>l>>r;

	int a[9]={0};
//	for(int t=0;t<9;t++){
//		cout<<a[t]<<endl;
//	}
	a[0] = r-l+1;

	for(int i=l;i<=r;i++){
		for(int j=2;j<=i;j++){
			//cout<<"?"<<i<<":"<<j<<endl;
			if(i%j==0){
				a[get(j)-1]++;
			}
		}
	}

	for(int k=0;k<9;k++){
		cout<<a[k];
		if(k!=8){
			cout<<endl;
		}
	}
}