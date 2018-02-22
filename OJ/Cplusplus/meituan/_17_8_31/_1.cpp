#include<iostream>
using namespace std;

int m=0;
int n,k;
/*
 *f:floor
 *c:count
 *s:sum
 */
void dfs(int p[],int f,int c,int s){
	cout<<f<<":"<<c<<":"<<s<<endl;
	if(f>=n&&s%k==0&&c>m){
		m=c;
	}
	if(n-f+c<m||f>=n){
		return;
	}else{
		dfs(p,f+1,c+1,s+p[f]);
		dfs(p,f+1,c,s);
	}
}

int main(){
	cin>>n;
	int *p = new int[n];
	for(int i=0;i<n;i++){
		cin>>p[i];
	}
	cin>>k;
	dfs(p,0,0,0);
	cout<<m<<endl;
}