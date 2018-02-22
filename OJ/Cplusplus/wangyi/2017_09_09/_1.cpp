#include<iostream>
using namespace std;
/*
 *c:current place
 *d:depth-count
 *l:total-length/max-length
 */
int dfs(int **p,int n,int l,int d,int c){
	if(d==l)return d;
	int m = 0;
	for(int i=0;i<n;i++){
		if(p[c][i]){
			p[c][i]=0;
			p[i][c]=0;
			int tmp = dfs(p,n,l,d+1,i);
			if(tmp>m){
				m=tmp;
			}
			p[c][i]=1;
			p[i][c]=1;
		}
	}
	return m;
}

int main(){
	int n,l;
	cin>>n>>l;
	//cout<<n<<":"<<l<<endl;
	int **p = new int*[n];
	int i,j,k,t;
	for(i=0;i<n;i++){
		p[i]=new int[n];
		for(j=0;j<n;j++){
			p[i][j]=0;
		}
	}
	//cout<<"memset"<<endl;
	//memset(p,0,n*n*sizeof(int));
	//cout<<"memset"<<endl;
	for(i=0;i<n-1;i++){
		cin>>t;
		//cout<<"???"<<endl;
		p[t][i+1]=1;
		p[i+1][t]=1;
		//cout<<"!!!"<<endl;
	}
	int res = dfs(p,n,l,0,0);
	cout<<res+1<<endl;
}