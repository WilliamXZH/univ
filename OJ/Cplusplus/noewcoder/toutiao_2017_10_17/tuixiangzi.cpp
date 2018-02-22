#include<iostream>
using namespace std;

int dfs(char **p,int n,int m,int x,int y){
	
}

int main(){
	char **p;
	int n,m;
	cin>>n>>m;
	p = new char*[n];
	for(int i=0;i<n;i++){
		p[i] = new char[m+1];
		cin>>p[i];
	}
	for(int j=0;j<n;j++){
		cout<<p[j]<<endl;
	}
}