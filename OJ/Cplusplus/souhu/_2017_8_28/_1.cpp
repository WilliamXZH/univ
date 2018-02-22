#include<iostream>
using namespace std;

int main(){
	int n,m;
	cin>>n>>m;
	int *a = new int[m];
	int c=0,x=0,y=0;
	int *p = new int[n];
	for(int l=0;l<m;l++){
		cin>>a[l];
	}
	//p[0] = a[0];
	while(c<n){
		if(c==y){
			p[c]=a[y];
		}
		if(y>=m){
			y=0;
		}
		//cout<<x<<":"<<y<<endl;
		for(int i=0;i<p[x];i++){
			p[c++] = a[y];	
		}
		x++;
		y++;
	}
	for(int j=0;j<n;j++){
		cout<<p[j]<<endl;
	}
}