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
	sort(z,z+n);
	while(z[n-m-1]!=0){
		int i=1;
		while(z[n-m]<z[n-m+1]){
			z[n-m]+=z[n-m-i];
			//cout<<z[n-m]<<endl;
			z[n-m-i]=0;
			i++;
		}
		sort(z,z+n);
	}
	cout<<z[n-m]<<endl;
}