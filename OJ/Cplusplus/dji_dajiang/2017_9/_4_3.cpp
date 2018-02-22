#include<iostream>
#include<algorithm>
using namespace std;

int main(){
	int n,m,r;
	cin>>n>>m>>r;
	int *z = new int[n];
	int i,j,k,t;
	for(i=0;i<n;i++){
		cin>>z[i];
		z[i] /= r;
	}
	sort(z,z+n);
	int *y = new int[m];
	//memset(y,0,m*sizeof(int));
	for(i=0;i<m;i++){
		y[i]=0;
	}
	for(j=n-1;j>=0;j--){
		t=0;
		for(k=1;k<m;k++){
			if(y[k]<y[t]){
				t=k;
			}
		}
		y[t] += z[j];
	}
	t=0;
	for(i=1;i<m;i++){
		if(y[i]<y[t]){
			t=i;
		}
	}
	cout<<y[t]<<endl;
}