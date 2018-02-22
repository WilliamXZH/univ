#include<iostream>
#include<algorithm>
using namespace std;

int main(){
	int n,m,r;
	cin>>n>>m>>r;
	int *z = new int[n];
	for(int i=0;i<n;i++){
		cin>>z[i];
		z[i] /= r;
	}
	int res = 0;
	while(true){
		bool con = false;
		sort(z,z+n);
		//cout<<z[0];
		int c= 0;
		for(int j=n-1;j>=0;j--){
			if(z[j]>0){
				z[j]--;
				c++;
			}
			if(c==m)break;
		}
		if(c==m){
			res++;
		}else{
			break;
		}
	}
	cout<<res<<endl;
}